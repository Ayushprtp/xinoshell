.class Lcom/google/xinoshell/activities/PhonepeActivity$1;
.super Landroid/webkit/WebViewClient;
.source "PhonepeActivity.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/google/xinoshell/activities/PhonepeActivity;->setupWebView()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/google/xinoshell/activities/PhonepeActivity;


# direct methods
.method constructor <init>(Lcom/google/xinoshell/activities/PhonepeActivity;)V
    .locals 0
    .param p1, "this$0"    # Lcom/google/xinoshell/activities/PhonepeActivity;
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010
        }
        names = {
            null
        }
    .end annotation

    .line 34
    iput-object p1, p0, Lcom/google/xinoshell/activities/PhonepeActivity$1;->this$0:Lcom/google/xinoshell/activities/PhonepeActivity;

    invoke-direct {p0}, Landroid/webkit/WebViewClient;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceivedError(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;Landroid/webkit/WebResourceError;)V
    .locals 3
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "request"    # Landroid/webkit/WebResourceRequest;
    .param p3, "error"    # Landroid/webkit/WebResourceError;

    .line 37
    invoke-super {p0, p1, p2, p3}, Landroid/webkit/WebViewClient;->onReceivedError(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;Landroid/webkit/WebResourceError;)V

    .line 38
    iget-object v0, p0, Lcom/google/xinoshell/activities/PhonepeActivity$1;->this$0:Lcom/google/xinoshell/activities/PhonepeActivity;

    const-string v1, "Page load error"

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 39
    return-void
.end method

.method public shouldOverrideUrlLoading(Landroid/webkit/WebView;Ljava/lang/String;)Z
    .locals 1
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "url"    # Ljava/lang/String;

    .line 43
    invoke-virtual {p1, p2}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    .line 44
    const/4 v0, 0x1

    return v0
.end method
