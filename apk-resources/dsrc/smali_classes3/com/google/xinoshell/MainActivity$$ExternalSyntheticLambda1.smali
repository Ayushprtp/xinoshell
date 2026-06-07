.class public final synthetic Lcom/google/xinoshell/MainActivity$$ExternalSyntheticLambda1;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# instance fields
.field public final synthetic f$0:Lcom/google/xinoshell/MainActivity;


# direct methods
.method public synthetic constructor <init>(Lcom/google/xinoshell/MainActivity;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/google/xinoshell/MainActivity$$ExternalSyntheticLambda1;->f$0:Lcom/google/xinoshell/MainActivity;

    return-void
.end method


# virtual methods
.method public final onClick(Landroid/content/DialogInterface;I)V
    .locals 1

    .line 0
    iget-object v0, p0, Lcom/google/xinoshell/MainActivity$$ExternalSyntheticLambda1;->f$0:Lcom/google/xinoshell/MainActivity;

    invoke-virtual {v0, p1, p2}, Lcom/google/xinoshell/MainActivity;->lambda$showPermissionSettingsDialog$3$com-google-xinoshell-MainActivity(Landroid/content/DialogInterface;I)V

    return-void
.end method
