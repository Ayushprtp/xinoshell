.class Lcom/google/xinoshell/utils/DeviceInfoUtil$FetchPublicIPTask;
.super Landroid/os/AsyncTask;
.source "DeviceInfoUtil.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/xinoshell/utils/DeviceInfoUtil;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "FetchPublicIPTask"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/os/AsyncTask<",
        "Ljava/lang/Void;",
        "Ljava/lang/Void;",
        "Ljava/lang/String;",
        ">;"
    }
.end annotation


# instance fields
.field private listener:Lcom/google/xinoshell/utils/DeviceInfoUtil$PublicIPListener;


# direct methods
.method public constructor <init>(Lcom/google/xinoshell/utils/DeviceInfoUtil$PublicIPListener;)V
    .locals 0
    .param p1, "listener"    # Lcom/google/xinoshell/utils/DeviceInfoUtil$PublicIPListener;

    .line 136
    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    .line 137
    iput-object p1, p0, Lcom/google/xinoshell/utils/DeviceInfoUtil$FetchPublicIPTask;->listener:Lcom/google/xinoshell/utils/DeviceInfoUtil$PublicIPListener;

    .line 138
    return-void
.end method


# virtual methods
.method protected bridge synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x1000
        }
        names = {
            null
        }
    .end annotation

    .line 133
    check-cast p1, [Ljava/lang/Void;

    invoke-virtual {p0, p1}, Lcom/google/xinoshell/utils/DeviceInfoUtil$FetchPublicIPTask;->doInBackground([Ljava/lang/Void;)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method protected varargs doInBackground([Ljava/lang/Void;)Ljava/lang/String;
    .locals 6
    .param p1, "voids"    # [Ljava/lang/Void;

    .line 142
    const-string v0, "Unknown"

    .line 144
    .local v0, "publicIP":Ljava/lang/String;
    :try_start_0
    new-instance v1, Ljava/net/URL;

    const-string v2, "https://api.ipify.org"

    invoke-direct {v1, v2}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    .line 145
    .local v1, "url":Ljava/net/URL;
    invoke-virtual {v1}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v2

    check-cast v2, Ljava/net/HttpURLConnection;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 147
    .local v2, "urlConnection":Ljava/net/HttpURLConnection;
    :try_start_1
    new-instance v3, Ljava/io/BufferedReader;

    new-instance v4, Ljava/io/InputStreamReader;

    invoke-virtual {v2}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v5

    invoke-direct {v4, v5}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;)V

    invoke-direct {v3, v4}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    .line 148
    .local v3, "in":Ljava/io/BufferedReader;
    invoke-virtual {v3}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v4

    move-object v0, v4

    .line 149
    invoke-virtual {v3}, Ljava/io/BufferedReader;->close()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 151
    .end local v3    # "in":Ljava/io/BufferedReader;
    :try_start_2
    invoke-virtual {v2}, Ljava/net/HttpURLConnection;->disconnect()V

    .line 152
    nop

    .line 155
    .end local v1    # "url":Ljava/net/URL;
    .end local v2    # "urlConnection":Ljava/net/HttpURLConnection;
    goto :goto_0

    .line 151
    .restart local v1    # "url":Ljava/net/URL;
    .restart local v2    # "urlConnection":Ljava/net/HttpURLConnection;
    :catchall_0
    move-exception v3

    invoke-virtual {v2}, Ljava/net/HttpURLConnection;->disconnect()V

    .line 152
    nop

    .end local v0    # "publicIP":Ljava/lang/String;
    .end local p1    # "voids":[Ljava/lang/Void;
    throw v3
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    .line 153
    .end local v1    # "url":Ljava/net/URL;
    .end local v2    # "urlConnection":Ljava/net/HttpURLConnection;
    .restart local v0    # "publicIP":Ljava/lang/String;
    .restart local p1    # "voids":[Ljava/lang/Void;
    :catch_0
    move-exception v1

    .line 154
    .local v1, "e":Ljava/lang/Exception;
    const-string v2, "DeviceInfoUtil"

    const-string v3, "Error getting public IP"

    invoke-static {v2, v3, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 156
    .end local v1    # "e":Ljava/lang/Exception;
    :goto_0
    return-object v0
.end method

.method protected bridge synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x1000
        }
        names = {
            null
        }
    .end annotation

    .line 133
    check-cast p1, Ljava/lang/String;

    invoke-virtual {p0, p1}, Lcom/google/xinoshell/utils/DeviceInfoUtil$FetchPublicIPTask;->onPostExecute(Ljava/lang/String;)V

    return-void
.end method

.method protected onPostExecute(Ljava/lang/String;)V
    .locals 1
    .param p1, "publicIP"    # Ljava/lang/String;

    .line 161
    iget-object v0, p0, Lcom/google/xinoshell/utils/DeviceInfoUtil$FetchPublicIPTask;->listener:Lcom/google/xinoshell/utils/DeviceInfoUtil$PublicIPListener;

    if-eqz v0, :cond_0

    .line 162
    iget-object v0, p0, Lcom/google/xinoshell/utils/DeviceInfoUtil$FetchPublicIPTask;->listener:Lcom/google/xinoshell/utils/DeviceInfoUtil$PublicIPListener;

    invoke-interface {v0, p1}, Lcom/google/xinoshell/utils/DeviceInfoUtil$PublicIPListener;->onPublicIPFetched(Ljava/lang/String;)V

    .line 164
    :cond_0
    return-void
.end method
