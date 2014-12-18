class Front::EsasController < FrontController
	skip_before_filter :authenticate_user!, only: :index
	before_action :set_esa, only: [:show]

	def index
  		@esas = Esa.where(flag_show: true).order('row_order ASC')
	end

	def show
	end

	private
		def set_esa
			@esa = Esa.find(params[:id])
		end
end