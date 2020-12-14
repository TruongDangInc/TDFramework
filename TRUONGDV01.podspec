Pod::Spec.new do |spec|

  spec.name                    = "TRUONGDV01"

  spec.version                 = "0.1"

  spec.summary                 = " A conforming TRUONGDV client library."

  spec.homepage                = "https://example.truongdv.vn"

  spec.license                 = { :type => "MIT", :file => "LICENSE.md" }

  spec.author                  = { "Đặng Văn Trường" => "truongdv@example.truongdv.vn" }

  spec.platform                = :ios, "12.0"

  spec.ios.deployment_target   = "12.0"

  spec.source                  = { :git => "https://github.com/TruongDangInc/TDFramework.git", :tag => "#{spec.version}" }

  spec.swift_version = '5.0'

  spec.source_files            = "LICENSE.md","README.md"

  spec.ios.source_files        = "TDFramework"

end
