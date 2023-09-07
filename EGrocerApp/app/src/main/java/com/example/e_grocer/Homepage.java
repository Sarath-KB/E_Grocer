package com.example.e_grocer;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.view.GravityCompat;
import androidx.drawerlayout.widget.DrawerLayout;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.Gravity;
import android.view.View;
import android.widget.TextView;

import com.squareup.picasso.Picasso;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class Homepage extends AppCompatActivity {

    DrawerLayout drawerLayout;
    String sh_name="MySh";
    String cid;
    TextView neworder,acorder,item,reject;
    String neworder1,acorder1,item1,reject1;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_homepage);
        drawerLayout = findViewById(R.id.drawer_loayout);

        neworder = findViewById(R.id.neworder);
        acorder = findViewById(R.id.acceptorder);
        item = findViewById(R.id.pendingorder);
        reject = findViewById(R.id.item);

        SharedPreferences sh=getSharedPreferences(sh_name,MODE_PRIVATE);
        cid=sh.getString("userid","");

        homeDetails a=new homeDetails();
        a.execute(cid);

    }

    public class homeDetails extends AsyncTask<String,String,String> {

        @Override
        protected String doInBackground(String... strings) {
            WebServiceCaller wb= new WebServiceCaller(getApplicationContext());
            wb.setSoapObject("homecount");
            wb.addProperty("deid",strings[0]);
            wb.callWebService();
            return wb.getResponse();
        }

        @Override
        protected void onPostExecute(String s) {
            super.onPostExecute(s);
            JSONArray job= null;
            Log.d("homedetails",s);
            try{
                job=new JSONArray(s);
                JSONObject jo=job.getJSONObject(0);
                neworder1=jo.getString("neworder")+"Nos";
                acorder1=jo.getString("acorder")+"Nos";
                item1=jo.getString("deliverypending")+"Nos";
                reject1=jo.getString("itemretrun")+"Nos";

                neworder.setText(neworder1);
                acorder.setText(acorder1);
                item.setText(item1);
                reject.setText(reject1);



            }catch(JSONException e){
                e.printStackTrace();
            }

        }
    }


    public  void ClickMenu(View view){
        openDrawer(drawerLayout);

    }
    public static void openDrawer(DrawerLayout drawerLayout) {
        drawerLayout.openDrawer(GravityCompat.START);
    }

    public void ClickLogo(View view){
        closeDrawer(drawerLayout);
    }

    public static  void closeDrawer(DrawerLayout drawerLayout) {

        if(drawerLayout.isDrawerOpen(GravityCompat.START))

        {
            drawerLayout.closeDrawer(GravityCompat.START);
        }
    }

    public void ClickHome(View view){
        recreate();
    }

    public void ClickProfile(View view){
        redirectActivity(this,UserProfile.class);
    }
    public void ClickEdit(View view){
        redirectActivity(this,EditProfile.class);
    }
    public void ClickPassword(View view){
        redirectActivity(this,Changepassword.class);
    }
    public void ClickShop(View view){
        redirectActivity(this,ShopDetails.class);
    }
    public void ClickAccept(View view){
        redirectActivity(this,AcceptedOrder.class);
    }

    public void ClickLogout(View view){
        logout(this);
    }

    public static void logout(Activity activity) {

        AlertDialog.Builder builder= new AlertDialog.Builder(activity);
        builder.setTitle("Logout");
        builder.setMessage("Are you sure want to logout ?");
        builder.setPositiveButton("YES", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
                activity.finishAffinity();
                System.exit(0);
            }
        });

        builder.setNegativeButton("NO", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
                dialogInterface.dismiss();
            }
        });
        builder.show();
    }

    public static  void redirectActivity(Activity activity,Class cls) {
        Intent i = new Intent(activity,cls);
        i.setFlags(i.FLAG_ACTIVITY_NEW_TASK);
        activity.startActivity(i);
    }

    public  void onPaused(){
        super.onPause();
        closeDrawer(drawerLayout);
    }
}
