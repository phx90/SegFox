require "rqrcode"
module ApplicationHelper
  def generate_qrcode(url)
    qr = RQRCode::QRCode.new(url)
    png = qr.as_png(
      bit_depth: 1,
      border_modules: 4,
      color_mode: ChunkyPNG::COLOR_GRAYSCALE,
      color: "black",
      file: nil,
      fill: "white",
      module_px_size: 6,
      resize_exactly_to: false,
      resize_gte_to: false,
      size: 200
    )

    # Converte para Base64 para exibir diretamente na view
    "data:image/png;base64,#{Base64.encode64(png.to_s)}"
  end
end
