// RSA, a suite of routines for performing RSA public-key computations in
// JavaScript.
//
// Requires BigInt.js and Barrett.js.
//
// Copyright 1998-2005 David Shapiro.
//
// You may use, re-use, abuse, copy, and modify this code to your liking, but
// please keep this header.
//
// Thanks!
// 
// Dave Shapiro
// dave@ohdave.com 

function RSAKeyPair(encryptionExponent, decryptionExponent, modulus)
{
	this.e = biFromHex(encryptionExponent);
	this.d = biFromHex(decryptionExponent);
	this.m = biFromHex(modulus);
	
	// We can do two bytes per digit, so
	// chunkSize = 2 * (number of digits in modulus - 1).
	// Since biHighIndex returns the high index, not the number of digits, 1 has
	// already been subtracted.
	//this.chunkSize = 2 * biHighIndex(this.m);
	
	////////////////////////////////// TYF
    	this.digitSize = 2 * biHighIndex(this.m) + 2;
	this.chunkSize = this.digitSize - 11; // maximum, anything lower is fine
	////////////////////////////////// TYF

	this.radix = 16;
	this.barrett = new BarrettMu(this.m);
}

function twoDigit(n)
{
	return (n < 10 ? "0" : "") + String(n);
}

function encryptedString(key, s)
// Altered by Rob Saunders (rob@robsaunders.net). New routine pads the
// string after it has been converted to an array. This fixes an
// incompatibility with Flash MX's ActionScript.
// Altered by Tang Yu Feng for interoperability with Microsoft's
// RSACryptoServiceProvider implementation.
{
	////////////////////////////////// TYF
	if (key.chunkSize > key.digitSize - 11)
	{
	    return "Error";
	}
	////////////////////////////////// TYF


	var a = new Array();
	var sl = s.length;
	
	var i = 0;
	while (i < sl) {
		a[i] = s.charCodeAt(i);
		i++;
	}

	//while (a.length % key.chunkSize != 0) {
	//	a[i++] = 0;
	//}

	var al = a.length;
	var result = "";
	var j, k, block;
	for (i = 0; i < al; i += key.chunkSize) {
		block = new BigInt();
		j = 0;
		
		//for (k = i; k < i + key.chunkSize; ++j) {
		//	block.digits[j] = a[k++];
		//	block.digits[j] += a[k++] << 8;
		//}
		
		////////////////////////////////// TYF
		// Add PKCS#1 v1.5 padding
		// 0x00 || 0x02 || PseudoRandomNonZeroBytes || 0x00 || Message
		// Variable a before padding must be of at most digitSize-11
		// That is for 3 marker bytes plus at least 8 random non-zero bytes
		var x;
		var msgLength = (i+key.chunkSize)>al ? al%key.chunkSize : key.chunkSize;
		
		// Variable b with 0x00 || 0x02 at the highest index.
		var b = new Array();
		for (x=0; x<msgLength; x++)
		{
		    b[x] = a[i+msgLength-1-x];
		}
		b[msgLength] = 0; // marker
		var paddedSize = Math.max(8, key.digitSize - 3 - msgLength);
	
		for (x=0; x<paddedSize; x++) {
		    b[msgLength+1+x] = Math.floor(Math.random()*254) + 1; // [1,255]
		}
		// It can be asserted that msgLength+paddedSize == key.digitSize-3
		b[key.digitSize-2] = 2; // marker
		b[key.digitSize-1] = 0; // marker
		
		for (k = 0; k < key.digitSize; ++j) 
		{
		    block.digits[j] = b[k++];
		    block.digits[j] += b[k++] << 8;
		}
		////////////////////////////////// TYF

		var crypt = key.barrett.powMod(block, key.e);
		var text = key.radix == 16 ? biToHex(crypt) : biToString(crypt, key.radix);
		result += text + " ";
	}
	return result.substring(0, result.length - 1); // Remove last space.
}

function decryptedString(key, s)
{
	var blocks = s.split(" ");
	var result = "";
	var i, j, block;
	for (i = 0; i < blocks.length; ++i) {
		var bi;
		if (key.radix == 16) {
			bi = biFromHex(blocks[i]);
		}
		else {
			bi = biFromString(blocks[i], key.radix);
		}
		block = key.barrett.powMod(bi, key.d);
		for (j = 0; j <= biHighIndex(block); ++j) {
			result += String.fromCharCode(block.digits[j] & 255,
			                              block.digits[j] >> 8);
		}
	}
	// Remove trailing null, if any.
	if (result.charCodeAt(result.length - 1) == 0) {
		result = result.substring(0, result.length - 1);
	}
	return result;
}

function base64encode(str)
{
	var base64EncodeChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
	var base64DecodeChars = new Array(
	-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
	-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
	-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 62, -1, -1, -1, 63,
	52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -1, -1, -1, -1, -1, -1,
	-1,  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14,
	15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -1, -1, -1, -1, -1,
	-1, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
	41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -1, -1, -1, -1, -1);
	var out, i, len;
	var c1, c2, c3;

	len = str.length;
	i = 0;
	out = "";
	while(i < len) {
	c1 = str.charCodeAt(i++) & 0xff;
	if(i == len)
	{
		out += base64EncodeChars.charAt(c1 >> 2);
		out += base64EncodeChars.charAt((c1 & 0x3) << 4);
		out += "==";
		break;
	}
	c2 = str.charCodeAt(i++);
	if(i == len)
	{
		out += base64EncodeChars.charAt(c1 >> 2);
		out += base64EncodeChars.charAt(((c1 & 0x3)<< 4) | ((c2 & 0xF0) >> 4));
		out += base64EncodeChars.charAt((c2 & 0xF) << 2);
		out += "=";
		break;
	}
	c3 = str.charCodeAt(i++);
	out += base64EncodeChars.charAt(c1 >> 2);
	out += base64EncodeChars.charAt(((c1 & 0x3)<< 4) | ((c2 & 0xF0) >> 4));
	out += base64EncodeChars.charAt(((c2 & 0xF) << 2) | ((c3 & 0xC0) >>6));
	out += base64EncodeChars.charAt(c3 & 0x3F);
	}
 return out;
}