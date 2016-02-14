define([], function() {
	var Utils = {
		redHexValues: function(num) {
			// TODO rewrite this
			// Returns num
			var hexValues = [];
			for (var i=0; i < 16; i++) {
				for (var k=0; k < 16; k++) {				
					var redValue = this.toHexChar(i) + this.toHexChar(k) + '0000';					
					hexValues.push(redValue);
				}
			}
			
			var interval = Math.floor(256/num);
			var finalHexValues = []
			for (var i=0; i < 256; i+=interval) {
				finalHexValues.push(hexValues[i]);
			}
			
			return finalHexValues;
		},
		toHexChar: function(number) {
			return number > 9 ? String.fromCharCode(55 + number) : String(number)
		}
	}
	return Utils;
});
