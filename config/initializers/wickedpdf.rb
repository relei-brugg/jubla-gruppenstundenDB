if Rails.env.staging? || Rails.env.production?
  exe_path = Rails.root.join('bin', 'wkhtmltopdf-amd64').to_s
else
  exe_path = Rails.root.join('bin', 'wkhtmltopdf').to_s
  # exe_path = '/usr/local/bin/wkhtmltopdf'
end