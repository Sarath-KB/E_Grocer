package com.example.e_grocer;

import android.content.Context;
import android.content.Intent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.squareup.picasso.Picasso;

import java.util.List;

import androidx.annotation.NonNull;
import androidx.cardview.widget.CardView;
import androidx.recyclerview.widget.RecyclerView;

public class AdapterShop extends  RecyclerView.Adapter<AdapterShop.MyViewHolder>{
    Context context;
    BeanShop cbc;
    List<BeanShop> lcb;

    public AdapterShop(List<BeanShop> lbc, Context applicationContext) {
        this.lcb=lbc;
        this.context=applicationContext;
    }
    @NonNull
    @Override
    public AdapterShop.MyViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View itemView= LayoutInflater.from(parent.getContext()).inflate(R.layout.single_shop,parent,false);
        return new MyViewHolder(itemView);
    }

    @Override
    public void onBindViewHolder(@NonNull AdapterShop.MyViewHolder holder, int position) {

        cbc=lcb.get(position);
        holder.sname.setText(cbc.getShopname());
        holder.saddress.setText(cbc.getShopaddress());
        holder.scontact.setText(cbc.getShopcontact());
        holder.semail.setText(cbc.getShopemail());
        holder.available.setText(cbc.getAvailable());
        String imgurl="http://192.168.1.6:8084/E-Grocer/Assets/Shop/"+cbc.getShopimage();

        Picasso.get().load(imgurl).into(holder.photo);

    }

    @Override
    public int getItemCount() {
        return lcb.size();
    }

    public class MyViewHolder extends RecyclerView.ViewHolder implements View.OnClickListener {
        TextView sname,saddress,scontact,semail,available;
        ImageView photo;
        CardView click;
        public MyViewHolder(@NonNull View itemView) {
            super(itemView);

            click=(CardView) itemView.findViewById(R.id.click);
            sname=(TextView)itemView.findViewById(R.id.sh_name);
            saddress=(TextView)itemView.findViewById(R.id.sh_address);
            scontact=(TextView)itemView.findViewById(R.id.sh_contact);
            semail=(TextView)itemView.findViewById(R.id.sh_email);
            available=(TextView)itemView.findViewById(R.id.sh_order);
            photo=(ImageView)itemView.findViewById(R.id.shopimage);

            click.setOnClickListener(this);

        }

        @Override
        public void onClick(View view) {
            int a=getAdapterPosition();

            cbc=lcb.get(a);
            String shopid=cbc.getShopid();
            int cunt=Integer.parseInt(cbc.getAvailable());
            if(view == click){
                if(cunt>0){
                    Intent i=new Intent(context,AvailableOrder.class);
                    i.putExtra("shopid",shopid);
                    view.getContext().startActivity(i);
                }
                else{
                    Toast.makeText(context.getApplicationContext(), "No available orders found", Toast.LENGTH_SHORT).show();

                }
            }
        }
    }
}
