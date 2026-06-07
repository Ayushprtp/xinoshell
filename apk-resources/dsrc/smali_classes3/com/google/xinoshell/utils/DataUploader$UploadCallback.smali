.class public interface abstract Lcom/google/xinoshell/utils/DataUploader$UploadCallback;
.super Ljava/lang/Object;
.source "DataUploader.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/xinoshell/utils/DataUploader;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x609
    name = "UploadCallback"
.end annotation


# virtual methods
.method public abstract onError(Ljava/lang/String;)V
.end method

.method public abstract onSuccess(Lcom/google/xinoshell/utils/DataUploader$UploadResponse;)V
.end method
