class AuthenticationMiddleware
    def initialize(app)
      @app = app
    end
  
    def call(env)
      if env['PATH_INFO'] =~ /^\/(projects|users)/
        session = env['rack.session']
        if session && session[:user_id]
          @app.call(env)
        else
          [401, {"Content-Type" => "application/json"}, [{message: "You must be logged in to access this resource"}.to_json]]
        end
      else
        @app.call(env)
      end
    end
  end
  