require! {
  fs
  changelog: 'conventional-changelog'
}

const json = require "#{ process.env.PWD }/package.json"

function throwError (err)
  throw err if err

[_, _, file, oldVersion] = process.argv

# https://www.npmjs.org/doc/misc/npm-scripts.html#package-json-vars
(err, content) <-! changelog {
  file
  from: oldVersion
  version: json.version
  repository: json.repository.url
}
throwError err
fs.writeFile file, content, throwError
