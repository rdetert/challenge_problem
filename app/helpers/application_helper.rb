module ApplicationHelper

  def nav_hilite(active, idle, path)
    return active if request.path == root_path && path == players_path
    request.path == path ? active : idle
  end

  def select_enum(f, field)
    concat f.label field, class: "block text-sm font-medium text-gray-700"
    vals = f.object.class.send(field.to_s.pluralize).keys.map{|k| [k, k]}
    f.select field, options_for_select(vals, f.object.send(field)), {}, {class: "mt-1 shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md"}
  end

  def select_collection(f, scope, field, collection, value_method, text_method, label_text)
    concat f.label field, label_text, class: "block text-sm font-medium text-gray-700"
    if scope == Player && !f.object.new_record?
      current_value = f.object.send(field)
      collection = (Array.wrap(scope.send(:find, current_value)) + collection).flatten
    end
    options = options_from_collection_for_select(collection, value_method, text_method, f.object.send(field))
    f.select field, options, {prompt: "Select #{scope}"}, {class: "mt-1 shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md"}
  end


end
