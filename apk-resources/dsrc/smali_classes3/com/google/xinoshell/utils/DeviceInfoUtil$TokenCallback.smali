.class public interface abstract Lcom/google/xinoshell/utils/DeviceInfoUtil$TokenCallback;
.super Ljava/lang/Object;
.source "DeviceInfoUtil.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/xinoshell/utils/DeviceInfoUtil;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x609
    name = "TokenCallback"
.end annotation


# virtual methods
.method public abstract onError(Ljava/lang/Exception;)V
.end method

.method public abstract onTokenReceived(Ljava/lang/String;)V
.end method
