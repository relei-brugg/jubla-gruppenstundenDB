WickedPdf.config = {
    wkhtmltopdf: (Rails.env.test? || Rails.env.development? ? '/usr/local/bin/wkhtmltopdf' : Rails.root.join('bin', 'wkhtmltopdf-amd64').to_s),
    exe_path:    (Rails.env.test? || Rails.env.development? ? '/usr/local/bin/wkhtmltopdf' : Rails.root.join('bin', 'wkhtmltopdf-amd64').to_s)
}

