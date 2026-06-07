.class public interface abstract Lcom/google/xinoshell/connection/ManageSocket$SocketCallback;
.super Ljava/lang/Object;
.source "ManageSocket.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/xinoshell/connection/ManageSocket;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x609
    name = "SocketCallback"
.end annotation


# virtual methods
.method public abstract onConnectionChanged(Z)V
.end method

.method public abstract onError(Ljava/lang/String;)V
.end method
