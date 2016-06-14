/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.owen.web;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.StringTokenizer;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author fermion10
 */
public class Util {

    public static void debugLog(Object logmessage) {
        if (Constant.LOG_LEVEL <= Constant.DEBUG) {
            System.out.println(logmessage);
        }
    }

    public static String getInitiativeTypeImage(String initType, String category) {
        String[][] maplist = null;
        String imgName = "panel_expertise_pic.png";
        if(category.equals(Constant.INITIATIVES_CATEGORY_INDIVIDUAL)) {
            maplist = Constant.INIT_TYPE_IMAGE_MAPPING[0];
        } else {
            maplist = Constant.INIT_TYPE_IMAGE_MAPPING[1];
        }
        if(maplist != null) {
            for(int j=0; j <maplist[0].length; j++) {
                if(maplist[0][j].equalsIgnoreCase(initType)) {
                     imgName = maplist[1][j];
                }
            }
        }
        return imgName;
    }
    public static void printLog(Object logmessage) {
        if (Constant.LOG_LEVEL <= Constant.INFO) {
            System.out.println(logmessage);
        }
    }

    public static void printException(Exception ex) {
        ex.printStackTrace();

    }
    
    public static String getDisplayDateFormat(Date date, String format) {
        //System.out.println(date);
        try {
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        return sdf.format(date);
        }catch(Exception ex) {
            return "";
        }
    }
    public static java.util.Date getStringToDate(String dateStr, String format) {
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        Date date = null;
        try {
            date = sdf.parse(dateStr);
        } catch (ParseException ex) {
            Util.printException(ex);
        }
        return date;
    }

    public static boolean validateText(String text, int minlength, int maxlength) {
        boolean validate = false;
        if (text != null) {
            if (text.length() >= minlength && text.length() <= maxlength) {
                validate = true;
            }
        }
        return validate;
    }
    
    public static int getIntValue(String val) {
        int iVal = 0;
        try {
            iVal = Integer.parseInt(val);
        }catch(NumberFormatException nfe) {
            Util.printException(nfe);
        }
        return iVal;
    }
    
    public static int getIntValue(String val, int defaultVal) {
        int iVal = defaultVal;
        try {
            iVal = Integer.parseInt(val);
        }catch(NumberFormatException nfe) {
            Util.printException(nfe);
        }
        return iVal;
    }
    
    public static boolean validateSpecialChar(String text) {
        boolean validate = false;
        if (text != null) {
            String regex = "[0-9a-zA-Z\\ &*\\-,_.\"'+()#!@$?/]*";
            validate = text.matches(regex);
        }
        return validate;
    }
    public static boolean isEmpty(String addvalue) {
    	boolean result = false;
    	if(addvalue == null || addvalue.equals("")) {
    		result =  true;
    	}
    	return result;
    }
    public static boolean checkForFutureDate(String dateStr, String dateFormat) {
        boolean isDateValid = true;
        try {
            SimpleDateFormat sdf = new SimpleDateFormat(dateFormat);
            String opFormat = sdf.format(sdf.parse(dateStr));
            if (opFormat.equals(dateStr)) {
                isDateValid = true;
            } else {
                isDateValid = false;
            }
            Date dt = new Date();
            if (dt.before(sdf.parse(dateStr))) {
                isDateValid = false;
            }
        } catch (Exception e) {
            isDateValid = false;
        }
        return isDateValid;
    }

    public static boolean validateDate(String dateStr, String dateFormat) {
        boolean isDateValid = true;
        try {
            SimpleDateFormat sdf = new SimpleDateFormat(dateFormat);
            String opFormat = sdf.format(sdf.parse(dateStr));
            if (opFormat.equals(dateStr)) {
                isDateValid = true;
            } else {
                isDateValid = false;
            }
        } catch (Exception e) {
            isDateValid = false;
        }
        return isDateValid;
    }

    public static boolean isTextWithMinLength(String addvalue, int minlength) {
        boolean result = false;
        if (addvalue != null && addvalue.length() >= minlength) {
            result = true;
        }
        return result;
    }

    public static boolean isValidInput(String addvalue) {
        String ALLCHAR_REGEX = "^[\n?@A-Za-z0-9() .\\/'_-]+$";
        Pattern mask = Pattern.compile(ALLCHAR_REGEX);
        Matcher matcher = mask.matcher(addvalue);
        return (matcher.matches());
    }

    public static boolean validateEmailID(String text) {
        boolean validate = true;
        if (text != null) {
            String regex = "^[\\w-_\\.+]*[\\w-_\\.]\\@([\\w]+\\.)+[\\w]+[\\w]$";
            validate = text.matches(regex);
        }
        return validate;
    }

    public static boolean isAlphaNumeric(String source) {
        String PINCODE_REGEX = "^[A-Za-z0-9]+$";
        Pattern mask = Pattern.compile(PINCODE_REGEX);
        Matcher matcher = mask.matcher(source);
        return (matcher.matches());
    }

    public static boolean isNumeric(String source) {
        String PINCODE_REGEX = "^[0-9]+$";
        Pattern mask = Pattern.compile(PINCODE_REGEX);
        Matcher matcher = mask.matcher(source);
        return (matcher.matches());
    }

    public static boolean isValidStreetAddress(String streetAddress) {
        String STREET_ADDRESS = "^[A-Za-z0-9 ,#-]+$";
        Pattern mask = Pattern.compile(STREET_ADDRESS);
        Matcher matcher = mask.matcher(streetAddress);
        return (matcher.matches());
    }

    public static boolean isValidMobileNumber(String source) {
        String MOBILE_REGEX = "^([7-9][0-9]{9})+$";
        Pattern mask = Pattern.compile(MOBILE_REGEX);
        Matcher matcher = mask.matcher(source);
        return (matcher.matches());
    }

    public static boolean validateLength(String text, int minlength, int maxlength) {
        boolean validate = true;
        if (text != null) {
            if (text.length() < minlength || text.length() > maxlength) {
                validate = false;
            }
        }
        return validate;
    }

    public static boolean checkDateBefore(String fromDate, String toDate, String format) {
        boolean validate = true;
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        try {
            java.util.Date frmDate = sdf.parse(fromDate);
            java.util.Date tDate = sdf.parse(toDate);
            if (frmDate.before(tDate)) {
                validate = false;
            }
        } catch (ParseException e) {
            Util.printException(e);
        }
        return validate;
    }

     public static boolean checkDateBefore(java.util.Date fromDate, java.util.Date toDate) {
        boolean validate = true;
        if (fromDate.before(toDate)) {
            validate = false;
        }
        return validate;
    }
    public static String removeSpaces(String s) {
        StringTokenizer st = new StringTokenizer(s, " ", false);
        String t = "";
        while (st.hasMoreElements()) {
            t += st.nextElement();
        }
        return t;
    }

    public static String getClientIpAddr(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_X_FORWARDED");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_X_CLUSTER_CLIENT_IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_CLIENT_IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_FORWARDED_FOR");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_FORWARDED");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_VIA");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("REMOTE_ADDR");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip;
    }

    public static String checkNullable(String val) {

        if (val != null) {
            val = removeDot(val);
            return val.trim();
        } else {
            return "";
        }

    }

    public static String removeDot(String val) {
        if (val != null && val.startsWith(".00")) {
            val = "00";
        }
        return val;
    }
    
    public static String replaceWord(String original, String find,
            String replacement) {
        int i = original.indexOf(find);
        if (i < 0) {
            return original; // return original if 'find' is not in it.
        }

        String partBefore = original.substring(0, i);
        String partAfter = original.substring(i + find.length());

        return partBefore + replacement + partAfter;
    }

    public static HashMap<Integer,HashMap<String, Integer>> getTypeList(java.util.List<java.util.Map<java.lang.String,java.lang.Object>> iList, String category) {
        HashMap<Integer,HashMap<String, Integer>> hasmap =  new  HashMap<Integer,HashMap<String, Integer>>();
       
       
        for(int i=0; i < iList.size(); i++) {
            if(iList.get(i).get("category").equals(category)) {
                HashMap<String, Integer> hmap = new HashMap<String, Integer>();
                
                Integer initiativeType = (Integer)iList.get(i).get("initiativeType");
                if(initiativeType != null ) {
                    if(hasmap.containsKey(initiativeType)) {
                        hmap = hasmap.get(initiativeType);
                    }
                    hmap.put((String)iList.get(i).get("status"), (Integer)iList.get(i).get("totalInitiatives"));
                    hasmap.put(initiativeType,hmap);
                }
            }
        }
        
        return hasmap;
    }
    
    public static boolean isValidGender(String gender) {
        if (gender != null && !(gender.equalsIgnoreCase("M") || gender.equalsIgnoreCase("Male") || gender.equalsIgnoreCase("F") || gender.equalsIgnoreCase("Female"))) {
            return false;
        }
        return true;
    }
    public static File saveFile(String storePath, String destinationFile,
			InputStream is, int allowedFileSize, boolean overwrite) throws IOException {
		String returnFileName = "";
		File dir = new File(storePath);
		if(!dir.exists()) {
			dir.mkdirs();
		}
		File f = new File(storePath + destinationFile);
		if(f.exists() && overwrite == false) {
			destinationFile = destinationFile.substring(0, destinationFile.lastIndexOf("."))+"_"+System.currentTimeMillis()+destinationFile.substring(destinationFile.lastIndexOf("."));
		}
		OutputStream os = new FileOutputStream(storePath + destinationFile);
		byte[] b = new byte[2048];
		int length;
		while ((length = is.read(b)) != -1) {
			os.write(b, 0, length);
		}
		is.close();
		os.close();
		f = new File(storePath + destinationFile);
		long fileSize = f.length()/1024;
		if(fileSize <= allowedFileSize) {
			returnFileName = destinationFile;
		}  else {
			f.delete();		
		}
		return f ;
	}
}
