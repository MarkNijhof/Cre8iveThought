JsHamcrest={version:"0.6.1",isMatcher:function(b){return b instanceof JsHamcrest.SimpleMatcher},areArraysEqual:function(b,a){if(b instanceof Array||a instanceof Array){if(b.length!=a.length)return false;for(var c=0;c<b.length;c++){var d=b[c],e=a[c];if(d instanceof Array||e instanceof Array)return JsHamcrest.areArraysEqual(d,e);else if(d!=e)return false}return true}else return b==a},SimpleMatcher:function(b){b=b||{};this.matches=b.matches;this.describeTo=b.describeTo;if(b.describeValueTo)this.describeValueTo=
b.describeValueTo},CombinableMatcher:function(b){JsHamcrest.SimpleMatcher.apply(this,arguments);b=b||{};this.and=function(a){var c=JsHamcrest.Matchers.allOf(this,a);return new JsHamcrest.CombinableMatcher({matches:c.matches,describeTo:function(d){d.appendDescriptionOf(c)}})};this.or=function(a){var c=JsHamcrest.Matchers.anyOf(this,a);return new JsHamcrest.CombinableMatcher({matches:c.matches,describeTo:function(d){d.appendDescriptionOf(c)}})}},Description:function(){var b="";this.get=function(){return b};
this.appendDescriptionOf=function(a){a&&a.describeTo(this);return this};this.append=function(a){if(a!=null)b+=a;return this};this.appendLiteral=function(a){var c;if(a===c)this.append("undefined");else if(a===null)this.append("null");else if(a instanceof Array)this.appendValueList("[",", ","]",a);else if(typeof a=="string")this.append('"'+a+'"');else a instanceof Function?this.append("Function"):this.append(a);return this};this.appendValueList=function(a,c,d,e){this.append(a);for(a=0;a<e.length;a++){a>
0&&this.append(c);this.appendLiteral(e[a])}this.append(d);return this};this.appendList=function(a,c,d,e){this.append(a);for(a=0;a<e.length;a++){a>0&&this.append(c);this.appendDescriptionOf(e[a])}this.append(d);return this}}};JsHamcrest.SimpleMatcher.prototype.describeValueTo=function(b,a){a.appendLiteral(b)};JsHamcrest.CombinableMatcher.prototype=new JsHamcrest.SimpleMatcher;JsHamcrest.CombinableMatcher.prototype.constructor=JsHamcrest.CombinableMatcher;JsHamcrest.Matchers={};
JsHamcrest.Matchers.truth=function(){return new JsHamcrest.SimpleMatcher({matches:function(b){return b},describeTo:function(b){b.append("truth")}})};JsHamcrest.Matchers.is=function(b){JsHamcrest.isMatcher(b)||(b=JsHamcrest.Matchers.equalTo(b));return new JsHamcrest.SimpleMatcher({matches:function(a){return b.matches(a)},describeTo:function(a){a.append("is ").appendDescriptionOf(b)}})};
JsHamcrest.Matchers.not=function(b){JsHamcrest.isMatcher(b)||(b=JsHamcrest.Matchers.equalTo(b));return new JsHamcrest.SimpleMatcher({matches:function(a){return!b.matches(a)},describeTo:function(a){a.append("not ").appendDescriptionOf(b)}})};JsHamcrest.Matchers.equalTo=function(b){return new JsHamcrest.SimpleMatcher({matches:function(a){if(b instanceof Array||a instanceof Array)return JsHamcrest.areArraysEqual(b,a);return a==b},describeTo:function(a){a.append("equal to ").appendLiteral(b)}})};
JsHamcrest.Matchers.anything=function(){return new JsHamcrest.SimpleMatcher({matches:function(){return true},describeTo:function(b){b.append("anything")}})};JsHamcrest.Matchers.nil=function(){return new JsHamcrest.SimpleMatcher({matches:function(b){return b==null},describeTo:function(b){b.appendLiteral(null)}})};JsHamcrest.Matchers.sameAs=function(b){return new JsHamcrest.SimpleMatcher({matches:function(a){return a===b},describeTo:function(a){a.append("same as ").appendLiteral(b)}})};
JsHamcrest.Matchers.raises=function(b){return new JsHamcrest.SimpleMatcher({matches:function(a){try{a()}catch(c){if(c.name==b)return true;else throw c;}return false},describeTo:function(a){a.append("raises ").append(b)}})};JsHamcrest.Matchers.raisesAnything=function(){return new JsHamcrest.SimpleMatcher({matches:function(b){try{b()}catch(a){return true}return false},describeTo:function(b){b.append("raises anything")}})};
JsHamcrest.Matchers.both=function(b){JsHamcrest.isMatcher(b)||(b=JsHamcrest.Matchers.equalTo(b));return new JsHamcrest.CombinableMatcher({matches:b.matches,describeTo:function(a){a.append("both ").appendDescriptionOf(b)}})};JsHamcrest.Matchers.either=function(b){JsHamcrest.isMatcher(b)||(b=JsHamcrest.Matchers.equalTo(b));return new JsHamcrest.CombinableMatcher({matches:b.matches,describeTo:function(a){a.append("either ").appendDescriptionOf(b)}})};
JsHamcrest.Matchers.allOf=function(){var b=arguments;if(b[0]instanceof Array)b=b[0];return new JsHamcrest.SimpleMatcher({matches:function(a){for(var c=0;c<b.length;c++){var d=b[c];JsHamcrest.isMatcher(d)||(d=JsHamcrest.Matchers.equalTo(d));if(!d.matches(a))return false}return true},describeTo:function(a){a.appendList("("," and ",")",b)}})};
JsHamcrest.Matchers.anyOf=function(){var b=arguments;if(b[0]instanceof Array)b=b[0];return new JsHamcrest.SimpleMatcher({matches:function(a){for(var c=0;c<b.length;c++){var d=b[c];JsHamcrest.isMatcher(d)||(d=JsHamcrest.Matchers.equalTo(d));if(d.matches(a))return true}return false},describeTo:function(a){a.appendList("("," or ",")",b)}})};JsHamcrest.Matchers.greaterThan=function(b){return new JsHamcrest.SimpleMatcher({matches:function(a){return a>b},describeTo:function(a){a.append("greater than ").appendLiteral(b)}})};
JsHamcrest.Matchers.greaterThanOrEqualTo=function(b){return new JsHamcrest.SimpleMatcher({matches:function(a){return a>=b},describeTo:function(a){a.append("greater than or equal to ").appendLiteral(b)}})};JsHamcrest.Matchers.lessThan=function(b){return new JsHamcrest.SimpleMatcher({matches:function(a){return a<b},describeTo:function(a){a.append("less than ").appendLiteral(b)}})};
JsHamcrest.Matchers.lessThanOrEqualTo=function(b){return new JsHamcrest.SimpleMatcher({matches:function(a){return a<=b},describeTo:function(a){a.append("less than or equal to ").append(b)}})};JsHamcrest.Matchers.notANumber=function(){return new JsHamcrest.SimpleMatcher({matches:function(b){return isNaN(b)},describeTo:function(b){b.append("not a number")}})};JsHamcrest.Matchers.divisibleBy=function(b){return new JsHamcrest.SimpleMatcher({matches:function(a){return a%b===0},describeTo:function(a){a.append("divisible by ").appendLiteral(b)}})};
JsHamcrest.Matchers.even=function(){return new JsHamcrest.SimpleMatcher({matches:function(b){return b%2===0},describeTo:function(b){b.append("even")}})};JsHamcrest.Matchers.odd=function(){return new JsHamcrest.SimpleMatcher({matches:function(b){return b%2!==0},describeTo:function(b){b.append("odd")}})};JsHamcrest.Matchers.between=function(b){return{and:function(a){var c=a,d=b;if(b>a){c=b;d=a}return new JsHamcrest.SimpleMatcher({matches:function(e){return e>=d&&e<=c},describeTo:function(e){e.append("between ").appendLiteral(d).append(" and ").appendLiteral(c)}})}}};
JsHamcrest.Matchers.closeTo=function(b,a){a||(a=0);return new JsHamcrest.SimpleMatcher({matches:function(c){return Math.abs(c-b)-a<=0},describeTo:function(c){c.append("number within ").appendLiteral(a).append(" of ").appendLiteral(b)}})};JsHamcrest.Matchers.zero=function(){return new JsHamcrest.SimpleMatcher({matches:function(b){return b===0},describeTo:function(b){b.append("zero")}})};
JsHamcrest.Matchers.equalIgnoringCase=function(b){return new JsHamcrest.SimpleMatcher({matches:function(a){return a.toUpperCase()==b.toUpperCase()},describeTo:function(a){a.append('equal ignoring case "').append(b).append('"')}})};JsHamcrest.Matchers.containsString=function(b){return new JsHamcrest.SimpleMatcher({matches:function(a){return a.indexOf(b)>=0},describeTo:function(a){a.append('contains string "').append(b).append('"')}})};
JsHamcrest.Matchers.startsWith=function(b){return new JsHamcrest.SimpleMatcher({matches:function(a){return a.indexOf(b)===0},describeTo:function(a){a.append("starts with ").appendLiteral(b)}})};JsHamcrest.Matchers.endsWith=function(b){return new JsHamcrest.SimpleMatcher({matches:function(a){return a.lastIndexOf(b)+b.length==a.length},describeTo:function(a){a.append("ends with ").appendLiteral(b)}})};
JsHamcrest.Matchers.matches=function(b){return new JsHamcrest.SimpleMatcher({matches:function(a){return b.test(a)},describeTo:function(a){a.append("matches ").appendLiteral(b)}})};JsHamcrest.Matchers.emailAddress=function(){var b=/^([a-z0-9_\.\-\+])+\@(([a-z0-9\-])+\.)+([a-z0-9]{2,4})+$/i;return new JsHamcrest.SimpleMatcher({matches:function(a){return b.test(a)},describeTo:function(a){a.append("email address")}})};
JsHamcrest.Matchers.hasMember=function(b){return new JsHamcrest.SimpleMatcher({matches:function(a){if(a)return b in a;return false},describeTo:function(a){a.append("has member ").appendLiteral(b)}})};JsHamcrest.Matchers.hasFunction=function(b){return new JsHamcrest.SimpleMatcher({matches:function(a){if(a)return b in a&&a[b]instanceof Function;return false},describeTo:function(a){a.append("has function ").appendLiteral(b)}})};
JsHamcrest.Matchers.instanceOf=function(b){return new JsHamcrest.SimpleMatcher({matches:function(a){return!!(a instanceof b)},describeTo:function(a){var c=b.name?b.name:"a class";a.append("instance of ").append(c)}})};JsHamcrest.Matchers.typeOf=function(b){return new JsHamcrest.SimpleMatcher({matches:function(a){return typeof a==b},describeTo:function(a){a.append("typeof ").append('"').append(b).append('"')}})};JsHamcrest.Matchers.object=function(){return new JsHamcrest.Matchers.instanceOf(Object)};
JsHamcrest.Matchers.string=function(){return new JsHamcrest.Matchers.typeOf("string")};JsHamcrest.Matchers.number=function(){return new JsHamcrest.Matchers.typeOf("number")};JsHamcrest.Matchers.bool=function(){return new JsHamcrest.Matchers.typeOf("boolean")};JsHamcrest.Matchers.func=function(){return new JsHamcrest.Matchers.instanceOf(Function)};
JsHamcrest.Matchers.hasItem=function(b){JsHamcrest.isMatcher(b)||(b=JsHamcrest.Matchers.equalTo(b));return new JsHamcrest.SimpleMatcher({matches:function(a){if(!(a instanceof Array))return false;for(var c=0;c<a.length;c++)if(b.matches(a[c]))return true;return false},describeTo:function(a){a.append("array contains item ").appendDescriptionOf(b)}})};JsHamcrest.Matchers.hasItems=function(){for(var b=[],a=0;a<arguments.length;a++)b.push(JsHamcrest.Matchers.hasItem(arguments[a]));return JsHamcrest.Matchers.allOf(b)};
JsHamcrest.Matchers.everyItem=function(b){JsHamcrest.isMatcher(b)||(b=JsHamcrest.Matchers.equalTo(b));return new JsHamcrest.SimpleMatcher({matches:function(a){if(!(a instanceof Array))return false;for(var c=0;c<a.length;c++)if(!b.matches(a[c]))return false;return true},describeTo:function(a){a.append("every item ").appendDescriptionOf(b)}})};
JsHamcrest.Matchers.isIn=function(){var b=JsHamcrest.Matchers.equalTo,a=arguments;if(a[0]instanceof Array)a=a[0];return new JsHamcrest.SimpleMatcher({matches:function(c){for(var d=0;d<a.length;d++)if(b(a[d]).matches(c))return true;return false},describeTo:function(c){c.append("one of ").appendLiteral(a)}})};JsHamcrest.Matchers.oneOf=JsHamcrest.Matchers.isIn;JsHamcrest.Matchers.empty=function(){return new JsHamcrest.SimpleMatcher({matches:function(b){return b.length===0},describeTo:function(b){b.append("empty")}})};
JsHamcrest.Matchers.hasSize=function(b){JsHamcrest.isMatcher(b)||(b=JsHamcrest.Matchers.equalTo(b));return new JsHamcrest.SimpleMatcher({matches:function(a){return b.matches(a.length)},describeTo:function(a){a.append("has size ").appendDescriptionOf(b)},describeValueTo:function(a,c){c.append(a.length)}})};JsHamcrest.Operators={};
JsHamcrest.Operators.filter=function(b,a){if(!(b instanceof Array)||a==null)return b;a instanceof JsHamcrest.SimpleMatcher||(a=JsHamcrest.Matchers.equalTo(a));for(var c=[],d=0;d<b.length;d++)a.matches(b[d])&&c.push(b[d]);return c};
JsHamcrest.Operators.assert=function(b,a,c){c=c?c:{};var d=new JsHamcrest.Description;if(a==null)a=JsHamcrest.Matchers.truth();else JsHamcrest.isMatcher(a)||(a=JsHamcrest.Matchers.equalTo(a));c.message&&d.append(c.message).append(". ");d.append("Expected ");a.describeTo(d);if(a.matches(b)){d.append(": Success");d.passed=true;c.pass&&c.pass(d.get())}else{d.passed=false;d.append(" but was ");a.describeValueTo(b,d);c.fail&&c.fail(d.get())}return d};
JsHamcrest.Integration=function(){var b=this;return{copyMembers:function(a,c){if(arguments.length==1){c=a;JsHamcrest.Integration.copyMembers(JsHamcrest.Matchers,c);JsHamcrest.Integration.copyMembers(JsHamcrest.Operators,c)}else if(a)for(var d in a)d in c||(c[d]=a[d])},installMatchers:function(a){JsHamcrest.Integration.copyMembers(a,JsHamcrest.Matchers)},installOperators:function(a){JsHamcrest.Integration.copyMembers(a,JsHamcrest.Operators)},WebBrowser:function(){JsHamcrest.Integration.copyMembers(b);
b.assertThat=function(a,c,d){return JsHamcrest.Operators.assert(a,c,{message:d,fail:function(e){alert("[FAIL] "+e)},pass:function(e){alert("[SUCCESS] "+e)}})}},Rhino:function(){JsHamcrest.Integration.copyMembers(b);b.assertThat=function(a,c,d){return JsHamcrest.Operators.assert(a,c,{message:d,fail:function(e){print("[FAIL] "+e+"\n")},pass:function(e){print("[SUCCESS] "+e+"\n")}})}},JsTestDriver:function(a){function c(d){d=new Error(d);d.name="AssertError";try{for(var e=/jshamcrest.*.js:/i,f=d.stack.split("\n"),
g="",h=0;h<f.length;h++)e.test(f[h])||(g+=f[h]+"\n");d.stack=g}catch(i){}throw d;}a=a?a:{};a=a.scope||b;JsHamcrest.Integration.copyMembers(a);a.assertThat=function(d,e,f){return JsHamcrest.Operators.assert(d,e,{message:f,fail:c})}},JsUnitTest:function(a){a=a?a:{};a=a.scope||JsUnitTest.Unit.Testcase.prototype;JsHamcrest.Integration.copyMembers(a);a.assertThat=function(c,d,e){var f=this;return JsHamcrest.Operators.assert(c,d,{message:e,fail:function(g){f.fail(g)},pass:function(){f.pass()}})}},YUITest:function(a){a=
a?a:{};a=a.scope||b;JsHamcrest.Integration.copyMembers(a);a.Assert=YAHOO.util.Assert;YAHOO.util.Assert.that=function(c,d,e){return JsHamcrest.Operators.assert(c,d,{message:e,fail:function(f){YAHOO.util.Assert.fail(f)}})}},QUnit:function(a){a=a?a:{};a=a.scope||b;JsHamcrest.Integration.copyMembers(a);a.assertThat=function(c,d,e){return JsHamcrest.Operators.assert(c,d,{message:e,fail:function(f){QUnit.ok(false,f)},pass:function(f){QUnit.ok(true,f)}})}},jsUnity:function(a){a=a?a:{};var c=a.scope||jsUnity.env.defaultScope;
a=a.attachAssertions||false;JsHamcrest.Integration.copyMembers(c);a&&jsUnity.attachAssertions(c);c.assertThat=function(d,e,f){return JsHamcrest.Operators.assert(d,e,{message:f,fail:function(g){throw g;}})}},screwunit:function(a){a=a?a:{};a=a.scope||Screw.Matchers;JsHamcrest.Integration.copyMembers(a);a.assertThat=function(c,d,e){return JsHamcrest.Operators.assert(c,d,{message:e,fail:function(f){throw f;}})}}}}();

