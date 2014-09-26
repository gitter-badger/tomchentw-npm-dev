require! {
  fs
  Path: path
  changelog: 'conventional-changelog'
}

const json = require Path.join process.env.PWD, 'package.json'

function throwError (err)
  throw err if err

[_, _, file, oldVersion] = process.argv

# https://www.npmjs.org/doc/misc/npm-scripts.html#package-json-vars
(err, content) <-! changelog {
  file
  from: "v#{ oldVersion }"
  version: json.version
  repository: json.repository.url
}
throwError err
const filepath = Path.join process.env.PWD, file
fs.writeFile filepath, content, throwError