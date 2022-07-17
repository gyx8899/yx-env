const {isWindowsOs, getNodeArgs, runFile} = require('./assets/libs/utils')

const {fileName, ...others} = getNodeArgs()
console.log('getNodeArgs', fileName, others)

const prefix = fileName.endsWith('.sh') ? (isWindowsOs() ? '' : 'bash ') : ''
const suffix = fileName.endsWith('.sh') ? Object.keys(others).map(key=>others[key]).join(' ') : Object.keys(others).map(key=>`--${key}=${others[key]}`).join(' ')

runFile(`${prefix}${fileName} ${suffix}`)
