#= require jquery
#= require jquery_ujs

#= require role
#= require jquery.role
#= require bootstrap
class RiichiPortal
  constructor: (@$container) ->
    self = this

    @$container.find('@backgroundHover').hover(
      -> $(this).parent().addClass('navbar__navs-dropdown-background')
      -> $(this).parent().removeClass('navbar__navs-dropdown-background')
    )
