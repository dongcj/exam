package com.tom.security;

import com.tom.util.SystemCode;
import java.security.Key;
import java.security.SecureRandom;
import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class DesEncrypt {
	Key key;

	public DesEncrypt() {
		getKey(SystemCode.DATABASE + SystemCode.SECURITYKEY);
	}

	public void getKey(String strKey) {
		try {
			KeyGenerator _generator = KeyGenerator.getInstance("DES");
			_generator.init(new SecureRandom(strKey.getBytes()));
			this.key = _generator.generateKey();
			_generator = null;
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public String getEncString(String strMing) {
		byte[] byteMi = (byte[]) null;
		byte[] byteMing = (byte[]) null;
		String strMi = "";
		BASE64Encoder base64en = new BASE64Encoder();
		try {
			byteMing = strMing.getBytes("UTF8");
			byteMi = getEncCode(byteMing);
			strMi = base64en.encode(byteMi);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			base64en = null;
			byteMing = (byte[]) null;
			byteMi = (byte[]) null;
		}
		return strMi;
	}

	public String getDesString(String strMi) {
		BASE64Decoder base64De = new BASE64Decoder();
		byte[] byteMing = (byte[]) null;
		byte[] byteMi = (byte[]) null;
		String strMing = "";
		try {
			byteMi = base64De.decodeBuffer(strMi);
			byteMing = getDesCode(byteMi);
			strMing = new String(byteMing, "UTF8");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			base64De = null;
			byteMing = (byte[]) null;
			byteMi = (byte[]) null;
		}
		return strMing;
	}

	private byte[] getEncCode(byte[] byteS) {
		byte[] byteFina = (byte[]) null;
		Cipher cipher;
		try {
			cipher = Cipher.getInstance("DES");
			cipher.init(1, this.key);
			byteFina = cipher.doFinal(byteS);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			cipher = null;
		}
		return byteFina;
	}

	private byte[] getDesCode(byte[] byteD) {
		byte[] byteFina = (byte[]) null;
		Cipher cipher;
		try {
			cipher = Cipher.getInstance("DES");
			cipher.init(2, this.key);
			byteFina = cipher.doFinal(byteD);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			cipher = null;
		}
		return byteFina;
	}

	public static void main(String[] args) {
	}
}