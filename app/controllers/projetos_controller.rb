class ProjetosController < ApplicationController
  before_action :set_projeto, only: [:show, :edit, :update, :destroy]

  # GET /projetos
  # GET /projetos.json
  def index
    @projetos = Projeto.all
  end

  # GET /projetos/1
  # GET /projetos/1.json
  def show
  end

  # GET /projetos/new
  def new
    @projeto = current_usuario.projetos.build
  #  @categorias = Categoria.all.map{ |e| [e.nome, e.id] }
  end

  # GET /projetos/1/edit
  def edit
    #@categorias = Categoria.all.map{ |e| [e.nome, e.id] }
    if @projeto.usuario_id != current_usuario.id
      redirect_to projeto_path
    end
  end

  # POST /projetos
  # POST /projetos.json
  def create
    @projeto = current_usuario.projetos.build(projeto_params)
    @projeto.categoria_id = params[:categoria_id]
    respond_to do |format|
      if @projeto.save
        format.html { redirect_to @projeto, notice: 'Projeto was successfully created.' }
        format.json { render :show, status: :created, location: @projeto }
      else
        format.html { render :new }
        format.json { render json: @projeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projetos/1
  # PATCH/PUT /projetos/1.json
  def update
    @projeto.categoria_id = params[:categoria_id]
    if @projeto.usuario_id == current_usuario.id
      respond_to do |format|

        if @projeto.update(projeto_params)
          format.html { redirect_to @projeto, notice: 'Projeto was successfully updated.' }
          format.json { render :show, status: :ok, location: @projeto }
        else
          format.html { render :edit }
          format.json { render json: @projeto.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /projetos/1
  # DELETE /projetos/1.json
  def destroy
    @projeto.destroy
    respond_to do |format|
      format.html { redirect_to projetos_url, notice: 'Projeto was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_projeto
      @projeto = Projeto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def projeto_params
      params.require(:projeto).permit(:titulo, :foto_projeto, :descricao, :instrucoes, :categoria_id, :link)
    end
end
