const Os = require('os')

/**
 * Determine whether the Node.js process runs on macOS.
 *
 * @returns {Boolean}
 */
module.exports.isWindowsOs = function () {
  // aix
  // android
  // darwin - Mac
  // freebsd
  // haiku
  // linux
  // openbsd
  // sunos
  // win32 - Windows
  // cygwin
  // netbsd
  return Os.platform() === 'win32'
}

module.exports.runFile = function (filePath) {
  const { exec } = require("child_process");
  exec(filePath, (error, stdout, stderr) => {
    // catch err, stdout, stderr
    if (error) {
      console.log('Error in exec file:', filePath, error);
      return;
    }
    if (stderr) {
      console.log('an error with file system');
      return;
    }
    console.log('Result of script execution', stdout);
  });
}

module.exports.getNodeArgs = function () {
  const args = {};
  process.argv.slice(2, process.argv.length).forEach((arg) => {
      // long arg
      if (arg.slice(0, 2) === "--") {
          const longArg = arg.split("=");
          const longArgFlag = longArg[0].slice(2, longArg[0].length);
          args[longArgFlag] = longArg.length > 1 ? longArg[1] : true;
          // eslint-disable-next-line brace-style
      } else if (arg[0] === "-") {
          const flags = arg.slice(1, arg.length).split("");
          flags.forEach((flag) => {
              args[flag] = true;
          });
      }
  });
  return args;
}
