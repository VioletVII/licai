package crf.util;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.sun.net.ssl.HttpsURLConnection;
/**
 * 3DES加解密
 * */
@SuppressWarnings("deprecation")
public class DES3Tool {
	public static Log log = LogFactory.getLog("DES3Tool");
	private static final String encrytkey = "CD5A81F9010A094CDBF1CB0C04345F16E2053A77D46D072E";
	/**
	 * 补全48位key
	 * @param key
	 * @return
	 */
	public static String toAddKey(String key){
		String str = key;
		int n = 48 - key.length();
		if(n > 0){
			str += str.substring(0, n);
		}
		return str;  
	}
	/**
	 * 	将十六进制字符串转换为byte[]
	 */
	public static byte[] hexByte(byte[] b) {
		if ((b.length % 2) != 0){
    		throw new IllegalArgumentException("长度不是偶数");
    	}
    	byte[] b2 = new byte[b.length / 2];
    	for (int n = 0; n < b.length; n += 2) {
    		String item = new String(b, n, 2);
    		b2[n / 2] = (byte) Integer.parseInt(item, 16);
    	}
    	return b2;
	}
	 /**
		 * 	将byte数组转换成十六进制字符串
		 * */
	public static String byteHex(byte[] b) {
		String hs="";
        String stmp="";

        for (int n=0;n<b.length;n++) {
            stmp=(Integer.toHexString(b[n] & 0XFF));
            if (stmp.length()==1){
           		hs=hs+"0"+stmp;
           }else{
            	hs=hs+stmp;
           }
        }
        return hs.toUpperCase();
	}
	   
	/**
	 * 3DES解密
	 * */
	public static byte[] toDecryptMode(byte[] data,byte[] key) throws Exception{
		
		byte[] DecByte=null;
		try {
			SecretKey deskey = new SecretKeySpec(key, "DESede");
			Cipher cipher = Cipher.getInstance("DESede/ECB/NOPADDING");
//			Cipher cipher = Cipher.getInstance("DESede");
			cipher.init(Cipher.DECRYPT_MODE, deskey);
			DecByte=cipher.doFinal(data);
		} catch (InvalidKeyException e) {
			throw new Exception("3DES解密出错");
		} catch (NoSuchAlgorithmException e) {
			throw new Exception("3DES解密出错");
		} catch (NoSuchPaddingException e) {
			throw new Exception("3DES解密出错");
		} catch (IllegalBlockSizeException e) {
			throw new Exception("3DES解密出错");
		} catch (BadPaddingException e) {
			throw new Exception("3DES解密出错");
		}
		return DecByte;
	}
	/**
	 * 3DES解密
	 * @throws Exception 
	 */
	public static String DeDes3(String des3) throws Exception{
		/**
		 * 秘钥
		 * */
		String key = encrytkey;
		String result = UnDes3Str(key, des3);
		
		return result;
	}
	
	
	public static String UnDes3Str(String key,String src) throws Exception{
		byte[] keyStr = toAddKey(key).getBytes();
		byte[] keyBytes=hexByte(keyStr);
		byte[] cSrcBytes = toDecryptMode(hexByte(src.getBytes()), keyBytes);
		String hexStr=byteHex(cSrcBytes);
		/**
		* 	将解密后字符串的后面的00去掉
		**/
		int len_new=hexStr.length();
		int len_old=len_new;
		for(int i=0;i<8;i++)
		{	
			len_old=len_new;
			hexStr=hexStr.replaceAll("00$", "");//c++加密补位在后面加00
		    hexStr=hexStr.replaceAll("06$", "");//java加密补位在后面加06
		    hexStr=hexStr.replaceAll("08$", "");
		    len_new=hexStr.length();
		    if(len_new==len_old)
		      	break;        
		}
		 byte[] DecByte=hexByte(hexStr.getBytes());
		 byte[] newtemp=new String(DecByte,"gbk").getBytes("utf-8");//这里写转换后的编码方式
         String newStr=new String(newtemp,"utf-8");//这里写转换后的编码方式
		return newStr;
	}
	/**
     *  转化字符串为十六进制编码
     */
	public static String toHexString(String s)   
	{   
		String str="";   
		for (int i=0;i<s.length();i++)   
		{   
			int ch = (int)s.charAt(i);   
			String s1 = Integer.toHexString(ch);   
			str = str + s1; 
		} 
		//自动添加补位00
		if((s.length())%8>0){
			int n=8-(s.length())%8;
			while((n--) >0){
				str+="00";
			}
		}
		return str;   
	} 
	public static String DoDes3(String des3) throws Exception{
		String key = encrytkey;
		return Des3Str(key, des3);
	}
	
	public static String Des3Str(String key,String src) throws Exception{
		byte[] keyStr = toAddKey(key).getBytes();
		byte[] keyBytes=hexByte(keyStr);
		byte[] sData=src.getBytes();
		sData=new String(sData,"UTF-8").getBytes("GBK");//这里写转换后的编码方式
		byte[] desData=sData;
		if(sData.length%8!=0){
			desData=new byte[(1+sData.length/8)*8];
			System.arraycopy(sData,0,desData,0,sData.length);
		}
		
		byte[] cSrcBytes = toEncryptMode(desData, keyBytes);
		String hexStr=byteHex(cSrcBytes);
		return hexStr;
	}
	/**
	 * 3DES加密
	 * */
	public static byte[] toEncryptMode(byte[] data,byte[] key) throws Exception{
		
		byte[] EncByte=null;
		try {
			SecretKey deskey = new SecretKeySpec(key, "DESede");
			Cipher cipher = Cipher.getInstance("DESede/ECB/NOPADDING");
			cipher.init(Cipher.ENCRYPT_MODE, deskey);
			EncByte=cipher.doFinal(data);
		} catch (InvalidKeyException e) {
			throw new Exception("3DES加密出错");
		} catch (NoSuchAlgorithmException e) {
			throw new Exception("3DES加密出错");
		} catch (NoSuchPaddingException e) {
			throw new Exception("3DES加密出错");
		} catch (IllegalBlockSizeException e) {
			throw new Exception("3DES加密出错");
		} catch (BadPaddingException e) {
			throw new Exception("3DES加密出错");
		}
		return EncByte;
	}
	
	@SuppressWarnings("unused")
	public static void main(String argv[])
	{
//		String bankCardNo = "";
//		String userIdCard = "";
//		String bankType = "";
//		String mobileNo = "";
//		String jobName = "";
		try{
//			bankCardNo = DES3Tool.DoDes3("信而富XQ");
//			System.out.println("信而富XQ="+bankCardNo);
//			System.out.println("555="+DES3Tool.DeDes3(bankCardNo));
//			System.out.println(URLDecoder.decode(DES3Tool.DeDes3("8D8D84CA4DDE07DFCA615B6403078072997226D55E29382B60E5D5641D6F6D0663A19C07065F87B57D73FAEDFFB3E37F14494A03CC9AA8B8A1F961A85CF8A6634677AEC9F0493AD1"), "GBK"));
//			JSONObject jsonresult=JSONObject.fromObject(URLDecoder.decode(DES3Tool.DeDes3("8D8D84CA4DDE07DFCA615B6403078072997226D55E29382B60E5D5641D6F6D0663A19C07065F87B57D73FAEDFFB3E37F14494A03CC9AA8B8A1F961A85CF8A6634677AEC9F0493AD1"), "GBK"));
			 
//			userIdCard = DES3Tool.DoDes3("123456789123456789");
//			System.out.println(userIdCard);
//			System.out.println(DES3Tool.DeDes3(userIdCard));
//			bankType = DES3Tool.DoDes3("招商银行");
//			System.out.println(bankType);
//			System.out.println(DES3Tool.DeDes3(bankType));
//			mobileNo = DES3Tool.DoDes3("1639943182");
//			System.out.println("d="+mobileNo);
//			System.out.println(DES3Tool.DeDes3(mobileNo));
			//李晓珺 加密后 应该是 18890A8400D36883
//			String str="李晓珺";
		//	{"result":1,"crf_uid":"8AEBE5F89E7C16C38AF2B85F19B66502","errMsg":
			//	"系统异常,请稍后再试.","qq_no":"F5D5879354564CC9F5976D3D62A286B9",
			//	"serviceType":5012,"loan_no":"3AF7AB8C3723232AA44BBD3BE88901DA"}
//			jobName = DES3Tool.DoDes3(str);
//			System.out.println("jobName="+jobName);
//		//{"cft_score2":0,"cft_score3":0,"cft_score1":0,"serviceType":1004,"loan":50000,"ip":"131.87.0.40","loan_location":"4F339D3A99909731","bank_card_type":4186,"user_name":"A1F921A33AA0A2EE","cft_score":0,"crf_uid":782597506,"loan_day":14,"job_name":1,"qq_no":"D9FEBB44AF370E05C6B0BC5EE0021F51","create_time":1416120855,"cft_score5":0,"user_id_card":"CB7F247B390CCE700046B3A3C8A04929025684775264A4B8","cft_score4":0,"bank_card_no":"ACFC7626DF86B29B782A3DA2D94C4233D029121B767839DD","loan_no":1615175623,"contract_No":"","mobile_no":"419A4120B4917A3E0CE9404D547B3D54"}
//			System.out.println("qq="+DES3Tool.DeDes3("F646C43FC8B5AF7374F0046C38EDE0C0"));
//			System.out.println("crf_uid="+DES3Tool.DeDes3("CB7F247B390CCE700046B3A3C8A04929025684775264A4B8"));
//			System.out.println("loan_no="+DES3Tool.DeDes3("6135AD68165D435B4E75DDE5DCDDCE7D"));
			System.out.println(DES3Tool.DeDes3("2c327b3174b2c8821e1da006f007f736"));
		}catch(Exception e){
	       log.error("3des加密异常", e);
		}
		
	}
	
	public static String simpleTest(String httpsURL) throws Exception {  
	    URL myurl = new URL(null,httpsURL,new com.sun.net.ssl.internal.www.protocol.https.Handler());
	    HttpsURLConnection con = (HttpsURLConnection) myurl.openConnection();  
	    InputStream ins = con.getInputStream();  
	    InputStreamReader isr = new InputStreamReader(ins);  
	    BufferedReader in = new BufferedReader(isr);  
	    String inputLine=in.readLine();  
	    in.close();  
	    return inputLine;
	}
}
