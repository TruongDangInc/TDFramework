Pod::Spec.new do |spec|

  spec.name                     = "TRUONGDV01"

  spec.version                  = "2.0"

  spec.summary                  = " A conforming TRUONGDV client library."

  spec.homepage                 = "https://example.truongdv.vn"

  spec.license                  = { :type => "MIT", :file => "LICENSE" }

  spec.author                   = { "Đặng Văn Trường" => "truongdv@example.truongdv.vn" }

  spec.platform                 = :ios, "12.0"

  spec.ios.deployment_target    = "12.0"

  spec.source                   = { :http => "https://github.com/TruongDangInc/TDFramework/releases/download/2.0/TDFramework-2.0.zip" }

  spec.swift_version            = "5.0"

  spec.source_files             = "LICENSE","README.md"

  spec.ios.vendored_frameworks  = "Frameworks/TDFramework.xcframework"

end
