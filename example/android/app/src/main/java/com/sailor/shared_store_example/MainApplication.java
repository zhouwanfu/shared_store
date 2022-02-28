package com.sailor.shared_store_example;

import android.app.Application;
import com.tencent.mmkv.MMKV;
import com.sailor.shared_store.SharedStorePlugin;
public class MainApplication extends Application {
    SharedStorePlugin plugin;
    @Override
    public void onCreate() {
        super.onCreate();
        MMKV.initialize(this);
        plugin = new SharedStorePlugin();
    }
}
