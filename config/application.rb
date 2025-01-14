require_relative 'boot'

require 'rails/all'

# Requerir las gemas listas en el Gemfile, incluyendo gemas que haya
# limitado a :test, :development, o :production.
Bundler.require(*Rails.groups)

module Cor1440
  class Application < Rails::Application

    config.load_defaults 7.0

    # Las configuraciones de config/environments/* tienen precedencia
    # sobre las especifciadas aquí.
    #
    # La configuración de la aplicación debería ir en archivos en
    # config/initializers -- todos los archivos .rb de esa ruta
    # se cargan automáticamente

    # Establecer Time.zone a la zona por omisión y que Active Record se
    # convierta a esa zona.
    # ejecute "rake -D time" para ver tareas relacionadas con encontrar
    # nombres de zonas. Por omisión es UTC.
    config.time_zone = 'America/Bogota'

    # El locale predeterminado es :en y se cargan todas las traducciones
    # de config/locales/*.rb,yml 
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :es

    config.active_record.schema_format = :sql

    puts "CONFIG_HOSTS="+ENV.fetch('CONFIG_HOSTS', 'defensor.info').to_s
    config.hosts.concat(
      ENV.fetch('CONFIG_HOSTS', 'defensor.info').downcase.split(";"))

    config.relative_url_root = ENV.fetch('RUTA_RELATIVA', '/iap/miviap')

    # sip
    config.x.formato_fecha = ENV.fetch('FORMATO_FECHA', 'dd/M/yyyy')

    # heb412
    config.x.heb412_ruta = Pathname(
      ENV.fetch('HEB412_RUTA', Rails.root.join('public', 'heb412').to_s)
    )

    # sivel2
    config.x.sivel2_consulta_web_publica = ENV['SIVEL2_CONSWEB_PUBLICA'] &&
      ENV['SIVEL2_CONSWEB_PUBLICA'] != ''

    config.x.sivel2_consweb_max = ENV.fetch('SIVEL2_CONSWEB_MAX', 2000)

    config.x.sivel2_consweb_epilogo = ENV.fetch(
      'SIVEL2_CONSWEB_EPILOGO', 
      '<br>Si requiere más puede suscribirse a SIVeL Pro'
    ).html_safe

    config.x.sivel2_mapaosm_diasatras = ENV.fetch(
      'SIVEL2_CONSWEB_EPILOGO', 182)

   end
end
