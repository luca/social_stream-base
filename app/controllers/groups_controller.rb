class GroupsController < InheritedResources::Base
  # Set group founder to current_subject
  # Must do before authorization
  before_filter :set_founder, :only => :new

  load_and_authorize_resource

  respond_to :html, :js

  def index
    @groups = Group.most(params[:most]).
                    alphabetic.
                    letter(params[:letter]).
                    search(params[:search]).
                    tagged_with(params[:tag]).
                    page(params[:page]).per(10)

    index! do |format|
      format.html { render :layout => (user_signed_in? ? 'application' : 'frontpage') }
    end
  end

  def show
    show! do |format|
      format.html { render :layout => (user_signed_in? ? 'application' : 'frontpage') }
    end
  end

  def create
    create! do |success, failure|
      success.html {
        self.current_subject = @group
        redirect_to :home
      }
    end
  end

  protected

  # Overwrite resource method to support slug
  # See InheritedResources::BaseHelpers#resource
  def resource
    @group ||= end_of_association_chain.find_by_slug!(params[:id])
  end

  private

  def set_founder
    return unless user_signed_in?

    params[:group]            ||= {}
    params[:group][:_founder] ||= current_subject.slug
  end
end
