
function getNodeArgs() {
  const args = {};
  process.argv
      .slice(2, process.argv.length)
      .forEach((arg) => {
        // long arg
        if (arg.slice(0, 2) === '--') {
          const longArg = arg.split('=');
          const longArgFlag = longArg[0].slice(2, longArg[0].length);
          args[longArgFlag] = longArg.length > 1 ? longArg[1] : true;
          // eslint-disable-next-line brace-style
        } else if (arg[0] === '-') {
          const flags = arg.slice(1, arg.length)
              .split('');
          flags.forEach((flag) => {
            args[flag] = true;
          });
        }
      });
  return args;
}

console.log(getNodeArgs());

require('@babel/register');

// require(getNodeArgs().filepath);
require('./test.js');
// require(getNodeArgs().filepath);

// writeDataToFile('./i18n.json', JSON.stringify({a: '1234', b: 234}, null, 4));
// console.log('Hello, run js in node');

// function writeDataToFile(fileDirName, data) {
//   fs.writeFile(fileDirName, data, (err) => {
//     // eslint-disable-next-line no-console
//     console.log(`${fileDirName}: ${err ? 'Write File failed!' : 'Saved successfully!'}`);
//   });
// }
//
// writeDataToFile('./i18n.json', JSON.stringify({a: '1234', b: 234}, null, 4));