(defsystem "infix-reader"
  :description "A reader macro to allow for infix syntax with { ... }"
  :author "Allan Wei <timeolord6677@gmail.com>"
  :licence "Unlicence"
  
  :components ((:module "src"
                :components
                ((:file "infix-reader")))))
