module SMSFuHelper  
  # Returns a collection of carriers to be used in your own select tag
  # e.g., <%= f.select :mobile_carrier, carrier_collection %>
  def carrier_collection
    SMSFu.carriers.sort.collect{ |carrier| [carrier[1]["name"], carrier[0]] }
  end
  
  # Returns a formatted select box filled with carriers
  # e.g., <%= carrier_select %>
  # - name => name of the method in which you want to store the carrier name
  # - phrase => default selected blank option in select box 
  # - selected => carrier to pre-select
  # - include_blank => Do you want the blank option tag (in ADDITION to the value-less 'phrase' option above)?
  def carrier_select(name = :mobile_carrier, phrase = "Select a Carrier", selected = nil, include_blank = true)
    options = phrase.nil? ? carrier_collection : include_blank ? [phrase,nil] + carrier_collection : [phrase] + carrier_collection
    select_tag name, options_for_select(options, selected || phrase)
  end

end
