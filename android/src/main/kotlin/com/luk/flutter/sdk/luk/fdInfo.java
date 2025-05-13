//canok 0924
package com.luk.flutter.sdk.luk;

import android.util.Log;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class fdInfo {
    private final String TAG;
    private int mProcessId;
    private final String fdPath;

    public static class fdNode {
        fdNode(int fd, String path) {
            this.fd = fd;
            this.path = path;
        }

        @Override
        public String toString() {
            return fd + "--->" + path;
        }

        private int fd;
        private String path;
    }

    fdInfo() {
        mProcessId = android.os.Process.myPid();
        TAG = mProcessId + "_fdInfo";
        fdPath = "/proc/" + mProcessId + "/fd";
    }

    public static List<fdNode> getfdlist() {
        int pid = android.os.Process.myPid();
        String fdpath = "/proc/" + pid + "/fd";
        List<fdNode> fdlist = new ArrayList<fdNode>();
        File fddir = new File(fdpath);
        if (fddir.exists() && fddir.canRead()) {
            String[] filePath = fddir.list();
            if (null != filePath) {
                for (String temp : filePath) {
                    File subfile = new File(fdpath + File.separator + temp);
                    try {
                        fdlist.add(new fdNode(Integer.parseInt(subfile.getName()), subfile.getCanonicalPath()));
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
        return fdlist;
    }
}