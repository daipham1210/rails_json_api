# Include this concern in your ApplicationController
# Must implement links_object and paginate_collection
module RenderJsonapi
  extend ActiveSupport::Concern
  include Pagy::Backend

  included do
    def render_jsonapi(*args)
      options = args.extract_options!
      collection = args.first
      if options[:paginate] == true
        per_page = options[:params][:per_page]
        collection = paginate_collection(collection, per_page)
      end

      serializer_key = options[:serializer] || compute_collection_type(collection)
      serializer_class_name = compute_serializer_name(serializer_key)
      serializer_options = build_fast_jsonapi_options(options)
      serializer_options[:links] = links_object(options[:meta]) if options[:meta] || options[:paginate] == true
      
      serialized_collection = serializer_class_name.new(collection, serializer_options)
      status = options[:status] || :ok
      byebug
      render jsonapi: serialized_collection, status: status
    end

  end

  private

  def compute_serializer_name(serializer_key)
    return serializer_key unless serializer_key.is_a? Symbol
    # version = self.class.controller_path.split("/").first.upcase.to_s
    serializer_name = serializer_key.to_s.classify + "Serializer"
    # (version + "::" + serializer_name).constantize
    serializer_name.constantize
  end

  def compute_collection_type(collection)
    if collection.is_a?(ActiveRecord::Relation)
      # ActiveRecord::Relation has a #klass method to divulge the class of records it contains
      collection_class = collection.klass
    else
      collection_class = collection.class
    end

    collection_class.base_class.name.to_sym
  end
  
  def links_object(meta)
    return pagy_metadata(@pagy) unless meta

    pagy_metadata(@pagy).merge! meta
  end

  def paginate_collection(collection, per_page)
    @pagy, collection = pagy(collection, items: per_page)
    collection
  end

  def build_fast_jsonapi_options(options)
    json_options = {
      params: options[:params] || {},
      meta: options[:meta] || {},
    }
    
    # json_options[:params][:current_user] = current_user
    
    includes = options[:include]
    if includes.present?
      json_options[:include] = includes_array(includes)
    end

    json_options
  end

  def includes_array(includes)
    includes.is_a?(Array) ? includes : [includes]
  end
end