/**
 * Parenscript Loader for Webpack
 * 
 * Automatically compiles Common Lisp / Parenscript (.lisp) files into 
 * standard JavaScript on the fly during development and production builds.
 * 
 * Assisted and engineered with Gemini collaboration.
 */

const { execSync } = require('child_process');

module.exports = function(source) {
    this.cacheable();
    const callback = this.async();

    // Get the absolute path of the current .lisp file directly from Webpack
    // and format backslashes for Lisp compatibility on Windows
    const filePath = this.resourcePath.replace(/\\/g, '/');

    try {
	const sbclExpr1 = `(progn (write-string (parenscript:ps-compile-file "'${filePath}'")))`;
        const sbclCommand = `sbcl --noinform --noprint --load \"loaders/ps-preload.lisp\" --eval '${sbclExpr1}'`;

        const jsCode = execSync(sbclCommand, { encoding: 'utf8' });

	// Print the compiled JavaScript code to the terminal/console for debugging
        console.log(`\n--- [Parenscript Compiled Output: ${filePath}] ---\n`);
        console.log(jsCode.trim());
        console.log(`\n----------------------------------------------------\n`);
	
        callback(null, jsCode);
    } catch (err) {
        callback(new Error(`[Parenscript Loader Error] Compilation failed: ${err.message.trim()}`));
    }
};
