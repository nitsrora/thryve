package com.example.browsr;

import android.app.Activity;
import android.content.Context;

import androidx.annotation.NonNull;

import java.util.HashMap;


import com.android.volley.NetworkResponse;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;


import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;

/** BrowsrPlugin */
public class BrowsrPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware{
  private MethodChannel channel;
  private Context context;
  private Activity activity;
  private int mStatusCode = 0;



  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "browsr");
    channel.setMethodCallHandler(this);
    context = flutterPluginBinding.getApplicationContext();
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getCall")) {
      HashMap<String, Object> data = (HashMap<String, Object>) call.arguments;
      String url = data.get("url").toString();
      makeApiCall(url, result);

    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    activity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {

  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {

  }

  @Override
  public void onDetachedFromActivity() {

  }

  private void makeApiCall(String url, Result result){
      RequestQueue requestQueue = Volley.newRequestQueue(context);
      StringRequest myRequest = new StringRequest(Request.Method.GET, url,
              new Response.Listener<String>() {

                @Override
                public void onResponse(String response) {
                  HashMap<String, Object> r = new HashMap<>();
                  r.put("status_code", mStatusCode);
                  r.put("data", response);
                  result.success(r);
                }
              },
              new Response.ErrorListener() {
                @Override
                public void onErrorResponse(VolleyError error) {
                  result.error("500","Error Response", error);
                }
              }
      ){
        @Override
        protected Response<String> parseNetworkResponse(NetworkResponse response) {
          if (response != null) {
            mStatusCode = response.statusCode;
          }
          return super.parseNetworkResponse(response);
        }
      };
      requestQueue.add(myRequest);
  }
}
