$ ->
  attributes  = new Array()
  sqft_values = new Array()

  $("#tabs-1 .unit").hide()
  $("#tabs-1 .unit").each ->
    $(this).show() if parseInt($(this).attr('data-sqft')) <=  100

  ##
  #
  $("#clear_filters").click ->
    $('#filters input:checkbox').removeAttr('checked')
    $('#filters input:radio').removeAttr('checked')
    $('#filter-small').attr('checked', 'checked')
    $("#tabs-1 .unit").hide()
    $("#tabs-1 .unit").each ->
      $(this).show() if parseInt($(this).attr('data-sqft')) <=  100

    attributes.length = sqft_values.length = 0
    $.uniform.update()

  ##
  #
  $(".attributes :checkbox").click ->
    attributes.length = 0

    $(".attributes :checkbox:checked").each ->
      attributes.push($(this).val())

    redraw_table()

  ##
  #
  $(".sqft2 :checkbox").click ->
    sqft_values.length = 0

    $(".sqft :checkbox:checked").each ->
      sqft_values.push($(this).val())

    redraw_table()

  ##
  #
  $(".sqft :radio").click ->
    sqft_values.length = 0

    $(".sqft :radio:checked").each ->
      sqft_values.push($(this).val())

    redraw_table()

  ##
  #
  redraw_table = () ->
    attr_val = if attributes.length > 0 then true else false
    sqft_val = if sqft_values.length > 0 then true else false

    $("#tabs-1 .unit").hide()
    $("#tabs-1 .unit").each ->
      attr_match  = attribute_matcher($(this).attr('data-description'))
      sqft_match  = sqft_matcher(parseInt($(this).attr('data-sqft')))

      $(this).show() if attr_val and sqft_val and attr_match and sqft_match
      $(this).show() if not attr_val and sqft_val and sqft_match
      $(this).show() if attr_val and not sqft_val and attr_match
      $("#tabs-1 .unit").show() if not attr_val and not sqft_val

  ##
  #
  attribute_matcher = (description) ->
    results = []

    for attribute in attributes
      regex  = new RegExp(attribute, "i")
      result = if description.match(regex) then true else false

      results.push(result)

    return true if $.inArray(false, results) is -1

    false
  ##
  #
  sqft_matcher = (sqft) ->
    for sqft_value in sqft_values
      min = parseInt(sqft_value.split("-")[0])
      max = parseInt(sqft_value.split("-")[1])

      return true if min is 501 and sqft > 500
      return true if sqft >= min and sqft <= max

      false
