const {isWindowsOs, getNodeArgs, runFile} = require('./assets/libs/utils')


const {fileName, ...others} = getNodeArgs()
console.log('getNodeArgs', fileName, others)
runFile(`${isWindowsOs() ? '' : 'bash '}${fileName}`)
