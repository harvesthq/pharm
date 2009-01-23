// zsombor: add authenticity_token to *all* ajax requests.
Ajax.Base.prototype.initialize = Ajax.Base.prototype.initialize.wrap(
  function(original, options){
    if(window._token){
      if(Object.isString(options.parameters)){
        options.parameters = options.parameters.toQueryParams();
      } else {
        options.parameters = options.parameters || {};
      }
      Object.extend(options.parameters, { authenticity_token: window._token});
    }
    return original(options);
  });