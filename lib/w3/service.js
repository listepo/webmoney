// Generated by CoffeeScript 1.6.3
var BaseService, ClassicBinding, Envelope, LightBinding, Signer, W3Service, service,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

BaseService = require('./base');

Signer = require('../signer');

Envelope = (function() {
  function Envelope() {}

  Envelope.prototype.generateRequestNumber = function() {
    return 3;
  };

  Envelope.prototype._unprepare = function(envelope) {
    return envelope['w3s.response'];
  };

  return Envelope;

})();

ClassicBinding = (function(_super) {
  __extends(ClassicBinding, _super);

  ClassicBinding.DEFAULT_HOST = 'w3s.webmoney.ru';

  function ClassicBinding(intf) {}

  ClassicBinding.prototype._path = function(options) {
    return '/asp/XML' + options.method + '.asp';
  };

  ClassicBinding.prototype._prepare = function(options) {
    var content;
    content = {
      reqn: this.generateRequestNumber(),
      wmid: this.wmid
    };
    content[options.container] = options.data;
    content.sign = this.signer.digest(this._signString(content, options.order));
    return {
      'w3s.request': content
    };
  };

  return ClassicBinding;

})(Binding);

LightBinding = (function(_super) {
  __extends(LightBinding, _super);

  LightBinding.DEFAULT_HOST = 'w3s.wmtransfer.com';

  function LightBinding(intf) {}

  LightBinding.prototype._path = function(options) {
    return '/asp/XML' + options.method + 'Cert.asp';
  };

  LightBinding.prototype._prepare = function(options) {
    var content;
    content = {
      reqn: this.generateRequestNumber()
    };
    content[options.container] = options.data;
    return {
      'w3s.request': content
    };
  };

  return LightBinding;

})(Binding);

service = new W3Service.Classic(wmid, key);

service = new W3Service.Light(cert);

service.outInvoices(callback);

W3Service = {
  Classic: new ClassicBinding(W3Interface),
  Light: new LightBinding(W3Interface)
};

module.exports = W3Service;