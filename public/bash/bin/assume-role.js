#!/usr/bin/env node

const exec = require('child_process').exec

let account = process.argv[2]

if (account == 'unset') {

  console.log("unset AWS_SECRET_ACCESS_KEY")
  console.log("unset AWS_ACCESS_KEY_ID")
  console.log("unset AWS_SESSION_TOKEN")

  console.log("# eval $(node assume-role.js unset)")

  return
}

exec(`aws sts assume-role --role-arn 'arn:aws:iam::${account}:role/Admin' --role-session-name ashen-session-${Math.random()}`, (err, stdout, stderr) => {

  if (err) {
    throw new Error(`failed to run assume-role: ${stderr}` , err)
  }

  let payload = JSON.parse(stdout)

  console.log(`export AWS_SECRET_ACCESS_KEY=${payload.Credentials.SecretAccessKey}`)
  console.log(`export AWS_ACCESS_KEY_ID=${payload.Credentials.AccessKeyId}`)
  console.log(`export AWS_SESSION_TOKEN=${payload.Credentials.SessionToken}`)

  console.log(`# eval $(node assume-role.js ${account})`)
})
