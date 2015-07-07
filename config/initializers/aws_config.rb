Aws.config.update({
  region: Rails.application.secrets.aws_region,
  credentials: Aws::Credentials.new(
    Rails.application.secrets.aws_credential_key, 
    Rails.application.secrets.aws_credential_secret
  )
})