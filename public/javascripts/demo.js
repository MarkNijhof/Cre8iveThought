
var DemoObject = function(){
	this.method_A = function(input){
		output = input * 2;
		
		this.method_B(output);
		this.method_D('test');
	}
	this.method_B = function(input){
		this.method_D('test');
		return ('test ' + input);
	}
	
	this.method_C = function(input){
		if (input === 0) {
			throw 'cannot devide by zero';
		}
	}

	this.method_D = function(input){
		
	}
	
	var method_E_result = false;
	this.method_E = function(){
		setTimeout(function(){
			method_E_result = true;
		}, 1000);
	}
	this.method_E_results = function(){
		return method_E_result;
	}
};

