package com.sailor.shared_store;

import android.app.Application;
import com.tencent.mmkv.MMKV;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;

public class SharedStore extends Application {
    private Map<String, MMKV> _MMKVPool;
    public SharedStore(){
        _MMKVPool = new HashMap<>();
    }

    private MMKV getMMKKVWithId(String MMKVId) {
        if (MMKVId == null) {
            assert false : "MMKVId is null";
            return null;
        }
        if (_MMKVPool == null) {
            assert false : "MMKVPool is null";
            return null;
        }
        return _MMKVPool.get(MMKVId);
    }

    public String createDefaultMMKV() {
        if (this.getMMKKVWithId("default") != null) {
            assert false : "Repeat initialization";
            return "false";
        }
        MMKV defaultMMKV = MMKV.mmkvWithID("default");
        this._MMKVPool.put("default", defaultMMKV);
        return "true";
    }

    public String addMMKV(String MMKVId) {
        if (this.getMMKKVWithId(MMKVId) == null) {
            MMKV customMMKV = MMKV.mmkvWithID(MMKVId);
            this._MMKVPool.put(MMKVId, customMMKV);
            return "true";
        } else {
            assert false : "Repeat add MMKV";
            return "false";
        }
    }

    public String storeVale(String MMKVId, int type, String key, String value) {
        String result = "false";
        MMKV mmkv = this.getMMKKVWithId(MMKVId);
        if (mmkv != null && key != null && value != null) {
            switch (type) {
                case 0 :
                    mmkv.putBoolean(key, value.equals("true") ? true : false);
                    break;
                case 1:
                    mmkv.putInt(key, Integer.parseInt(value));
                    break;
                case 2:
                    mmkv.putFloat(key, Float.parseFloat(value));
                    break;
                case 3:
                    mmkv.putString(key, value);
            }
            result = "true";
        }
        return result;
    }

    public String readValue(String MMKVId, int type, String key) {
        String result = null;
        MMKV mmkv = this.getMMKKVWithId(MMKVId);
        if (mmkv != null && key != null ) {
            switch (type) {
                case 0:
                    result = mmkv.getBoolean(key, false) == true ? "true" : "false";
                    break;
                case 1:
                    result = Integer.toString(mmkv.getInt(key, Integer.MIN_VALUE));
                    break;
                case 2:
                    result = Float.toString(mmkv.getFloat(key, Float.MIN_VALUE));
                    break;
                case 3:
                    result = mmkv.getString(key,null);
            }
        }
        return result;
    }

    public String removeValue(String MMKVId, String key) {
        String result = "false";
        MMKV mmkv = this.getMMKKVWithId(MMKVId);
        if (key != null && mmkv != null) {
            mmkv.removeValueForKey(key);
            result = "true";
        }
        return result;
    }
}

