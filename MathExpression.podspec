Pod::Spec.new do |spec|
  spec.name         = 'MathExpression'
  spec.version      = '1.0.1'
  spec.summary      = 'Framework to parse and evaluate arithmetic mathematical expressions given by a String'
  spec.description  = 'This framework provides an algorithm and an API to easily evaluate arithmetic mathematical expressions given by a String. In addition to the basic arithmetic operators (addition, subtraction, product and division), we can pass in a transformation (in the form of a block) to add flexibility in the expressions provided.'
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  spec.homepage     = 'https://github.com/peredaniel/MathExpression.git'
  spec.authors      = { 'Pere Daniel Prieto' => 'math.pedro.daniel.prieto@gmail.com' }
  spec.source       = { :git => 'https://github.com/peredaniel/MathExpression.git', :tag => spec.version }

  spec.ios.deployment_target  = '10.0'
  spec.swift_version = "5.0"

  spec.ios.source_files = ['MathExpression/**/*.{h,m,swift}']
end
