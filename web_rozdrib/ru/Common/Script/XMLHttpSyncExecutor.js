Type.registerNamespace('Sys.Net');

Sys.Net.XMLHttpSyncExecutor = function()
{
	if (arguments.length !== 0) throw Error.parameterCount();
	Sys.Net.XMLHttpSyncExecutor.initializeBase(this);

	var _this = this;
	this._xmlHttpRequest = null;
	this._webRequest = null;
	this._responseAvailable = false;
	this._timedOut = false;
	this._timer = null;
	this._aborted = false;
	this._started = false;

	this._responseData = null;
	this._statusCode = null;
	this._statusText = null;
	this._headers = null;

	this._onReadyStateChange = function()
	{
		if (_this._xmlHttpRequest.readyState === 4)
		{
			_this._clearTimer();
			_this._responseAvailable = true;

			_this._responseData = _this._xmlHttpRequest.responseText;
			_this._statusCode = _this._xmlHttpRequest.status;
			_this._statusText = _this._xmlHttpRequest.statusText;
			_this._headers = _this._xmlHttpRequest.getAllResponseHeaders();

			_this._webRequest.completed(Sys.EventArgs.Empty);
			if (_this._xmlHttpRequest != null)
			{
				_this._xmlHttpRequest.onreadystatechange = Function.emptyMethod;
				_this._xmlHttpRequest = null;
			}
		}
	}

	this._clearTimer = function this$_clearTimer()
	{
		if (_this._timer != null)
		{
			window.clearTimeout(_this._timer);
			_this._timer = null;
		}
	}

	this._onTimeout = function this$_onTimeout()
	{
		if (!_this._responseAvailable)
		{
			_this._clearTimer();
			_this._timedOut = true;
			_this._xmlHttpRequest.onreadystatechange = Function.emptyMethod;
			_this._xmlHttpRequest.abort();
			_this._webRequest.completed(Sys.EventArgs.Empty);
			_this._xmlHttpRequest = null;
		}
	}
}

function Sys$Net$XMLHttpSyncExecutor$get_timedOut()
{
	/// <value type="Boolean"></value>
	if (arguments.length !== 0) throw Error.parameterCount();
	return this._timedOut;
}

function Sys$Net$XMLHttpSyncExecutor$get_started()
{
	/// <value type="Boolean"></value>
	if (arguments.length !== 0) throw Error.parameterCount();
	return this._started;
}

function Sys$Net$XMLHttpSyncExecutor$get_responseAvailable()
{
	/// <value type="Boolean"></value>
	if (arguments.length !== 0) throw Error.parameterCount();
	return this._responseAvailable;
}

function Sys$Net$XMLHttpSyncExecutor$get_aborted()
{
	/// <value type="Boolean"></value>
	if (arguments.length !== 0) throw Error.parameterCount();
	return this._aborted;
}

function Sys$Net$XMLHttpSyncExecutor$executeRequest()
{
	if (arguments.length !== 0) throw Error.parameterCount();
	this._webRequest = this.get_webRequest();

	if (this._started)
	{
		throw Error.invalidOperation(String.format(Sys.Res.cannotCallOnceStarted, 'executeRequest'));
	}
	if (this._webRequest === null)
	{
		throw Error.invalidOperation(Sys.Res.nullWebRequest);
	}

	var body = this._webRequest.get_body();
	var headers = this._webRequest.get_headers();
	this._xmlHttpRequest = new XMLHttpRequest();
	this._xmlHttpRequest.onreadystatechange = this._onReadyStateChange;
	var verb = this._webRequest.get_httpVerb();
	this._xmlHttpRequest.open(verb, this._webRequest.getResolvedUrl(), false); // False to call Synchronously
	if (headers)
	{
		for (var header in headers)
		{
			var val = headers[header];
			if (typeof (val) !== 'function')
				this._xmlHttpRequest.setRequestHeader(header, val);
		}
	}

	if (verb.toLowerCase() === 'post')
	{
		if ((headers === null) || !headers['Content-Type'])
		{
			this._xmlHttpRequest.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
		}

		if (!body)
		{
			body = '';
		}
	}

	var timeout = this._webRequest.get_timeout();
	if (timeout > 0)
	{
		this._timer = window.setTimeout(Function.createDelegate(this, this._onTimeout), timeout);
	}
	this._xmlHttpRequest.send(body);
	this._started = true;
}

function Sys$Net$XMLHttpSyncExecutor$getAllResponseHeaders()
{
	/// <returns type="String"></returns>
	if (arguments.length !== 0) throw Error.parameterCount();
	if (!this._responseAvailable)
	{
		throw Error.invalidOperation(String.format(Sys.Res.cannotCallBeforeResponse, 'getAllResponseHeaders'));
	}

	return this._headers;
}

function Sys$Net$XMLHttpSyncExecutor$get_responseData()
{
	/// <value type="String"></value>
	if (arguments.length !== 0) throw Error.parameterCount();
	if (!this._responseAvailable)
	{
		throw Error.invalidOperation(String.format(Sys.Res.cannotCallBeforeResponse, 'get_responseData'));
	}

	return this._responseData;
}

function Sys$Net$XMLHttpSyncExecutor$get_statusCode()
{
	/// <value type="Number"></value>
	if (arguments.length !== 0) throw Error.parameterCount();
	if (!this._responseAvailable)
	{
		throw Error.invalidOperation(String.format(Sys.Res.cannotCallBeforeResponse, 'get_statusCode'));
	}

	return this._statusCode;
}

function Sys$Net$XMLHttpSyncExecutor$get_statusText()
{
	/// <value type="String"></value>
	if (arguments.length !== 0) throw Error.parameterCount();
	if (!this._responseAvailable)
	{
		throw Error.invalidOperation(String.format(Sys.Res.cannotCallBeforeResponse, 'get_statusText'));
	}

	return this._statusText;
}

function Sys$Net$XMLHttpSyncExecutor$get_xml()
{
	/// <value></value>
	if (arguments.length !== 0) throw Error.parameterCount();
	if (!this._responseAvailable)
	{
		throw Error.invalidOperation(String.format(Sys.Res.cannotCallBeforeResponse, 'get_xml'));
	}

	var xml = this._responseData;
	if ((!xml) || (!xml.documentElement))
	{
		xml = new XMLDOM(this._responseData);
		if ((!xml) || (!xml.documentElement))
		{
			return null;
		}
	}
	else if (navigator.userAgent.indexOf('MSIE') !== -1)
	{
		xml.setProperty('SelectionLanguage', 'XPath');
	}

	if ((xml.documentElement.namespaceURI === 'http://www.mozilla.org/newlayout/xml/parsererror.xml') &&
        (xml.documentElement.tagName === 'parsererror'))
	{
		return null;
	}

	if (xml.documentElement.firstChild && xml.documentElement.firstChild.tagName === 'parsererror')
	{
		return null;
	}

	return xml;
}

function Sys$Net$XMLHttpSyncExecutor$abort()
{
	if (arguments.length !== 0) throw Error.parameterCount();
	if (!this._started)
	{
		throw Error.invalidOperation(Sys.Res.cannotAbortBeforeStart);
	}

	if (this._aborted || this._responseAvailable || this._timedOut)
		return;

	this._aborted = true;

	this._clearTimer();

	if (this._xmlHttpRequest && !this._responseAvailable)
	{
		this._xmlHttpRequest.onreadystatechange = Function.emptyMethod;
		this._xmlHttpRequest.abort();

		this._xmlHttpRequest = null;
		var handler = this._webRequest._get_eventHandlerList().getHandler('completed');
		if (handler)
		{
			handler(this, Sys.EventArgs.Empty);
		}
	}
}

Sys.Net.XMLHttpSyncExecutor.prototype = {
	get_timedOut: Sys$Net$XMLHttpSyncExecutor$get_timedOut,
	get_started: Sys$Net$XMLHttpSyncExecutor$get_started,
	get_responseAvailable: Sys$Net$XMLHttpSyncExecutor$get_responseAvailable,
	get_aborted: Sys$Net$XMLHttpSyncExecutor$get_aborted,
	executeRequest: Sys$Net$XMLHttpSyncExecutor$executeRequest,
	getAllResponseHeaders: Sys$Net$XMLHttpSyncExecutor$getAllResponseHeaders,
	get_responseData: Sys$Net$XMLHttpSyncExecutor$get_responseData,
	get_statusCode: Sys$Net$XMLHttpSyncExecutor$get_statusCode,
	get_statusText: Sys$Net$XMLHttpSyncExecutor$get_statusText,
	get_xml: Sys$Net$XMLHttpSyncExecutor$get_xml,
	abort: Sys$Net$XMLHttpSyncExecutor$abort
}
Sys.Net.XMLHttpSyncExecutor.registerClass('Sys.Net.XMLHttpSyncExecutor', Sys.Net.WebRequestExecutor);

if (typeof (Sys) != 'undefined')
{
	Sys.Application.notifyScriptLoaded();
}