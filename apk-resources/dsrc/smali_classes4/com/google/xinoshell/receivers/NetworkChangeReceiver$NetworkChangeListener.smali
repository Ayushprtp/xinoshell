.class public interface abstract Lcom/google/xinoshell/receivers/NetworkChangeReceiver$NetworkChangeListener;
.super Ljava/lang/Object;
.source "NetworkChangeReceiver.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/xinoshell/receivers/NetworkChangeReceiver;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x609
    name = "NetworkChangeListener"
.end annotation


# virtual methods
.method public abstract onNetworkAvailable()V
.end method

.method public abstract onNetworkLost()V
.end method
