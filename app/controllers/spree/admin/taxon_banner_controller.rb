class Spree::Admin::TaxonBannerController < Spree::Admin::ResourceController
  helper 'spree/products'

  def new
    if Spree::TaxonBanner.count > 0
      id = Spree::TaxonBanner.last.id
      redirect_to( action: :edit, id: id )
    else
      @banner = Spree::TaxonBanner.create
      redirect_to( action: :edit, id: @banner.id )
    end
  end

  def show
    redirect_to( action: :edit, id: params[:id] )
  end

  def edit
    @banner = Spree::TaxonBanner.find(params[:id])
  end

  def update
    invoke_callbacks(:update, :before)
    if @object.update_attributes(permitted_resource_params)
      invoke_callbacks(:update, :after)
      flash[:success] = flash_message_for(@object, :successfully_updated)
      redirect_to( action: :edit, id: @object.id )
    else
      invoke_callbacks(:update, :fails)
      flash.now[:error] = @object.errors.full_messages.join(", ")
      redirect_to( action: :edit, id: @object.id )
    end

  end

end
