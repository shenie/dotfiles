#!/usr/bin/env node

let accounts = require(`${process.env.HOME}/bin/aws-accounts.js`)

const exec = require('child_process').exec

let account = process.argv[2]
let mfaCode = process.argv[3]

if (account == 'unset') {
  console.log("unset AWS_ACCT")
  console.log("unset AWS_SECRET_ACCESS_KEY")
  console.log("unset AWS_ACCESS_KEY_ID")
  console.log("unset AWS_SESSION_TOKEN")

  return
}

exec(`aws sts assume-role --serial-number ${accounts.userArn} --token-code ${mfaCode} --role-arn 'arn:aws:iam::${accounts.mappings[account].acct}:role/${accounts.mappings[account].role}' --duration-seconds 28800 --role-session-name ashen-session-abc`, (err, stdout, stderr) => {

  if (err) {
    throw new Error(`failed to run assume-role: ${stderr}` , err)
  }

  let payload = JSON.parse(stdout)

  console.log(`export AWS_ACCT=${account}`)
  console.log(`export AWS_SECRET_ACCESS_KEY=${payload.Credentials.SecretAccessKey}`)
  console.log(`export AWS_ACCESS_KEY_ID=${payload.Credentials.AccessKeyId}`)
  console.log(`export AWS_SESSION_TOKEN=${payload.Credentials.SessionToken}`)

})
