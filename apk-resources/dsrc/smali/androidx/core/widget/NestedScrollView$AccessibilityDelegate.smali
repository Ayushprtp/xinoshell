.class Landroidx/core/widget/NestedScrollView$AccessibilityDelegate;
.super Landroidx/core/view/AccessibilityDelegateCompat;
.source "NestedScrollView.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/core/widget/NestedScrollView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = "AccessibilityDelegate"
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 2101
    invoke-direct {p0}, Landroidx/core/view/AccessibilityDelegateCompat;-><init>()V

    return-void
.end method


# virtual methods
.method public onInitializeAccessibilityEvent(Landroid/view/View;Landroid/view/accessibility/AccessibilityEvent;)V
    .locals 3
    .param p1, "host"    # Landroid/view/View;
    .param p2, "event"    # Landroid/view/accessibility/AccessibilityEvent;

    .line 2166
    invoke-super {p0, p1, p2}, Landroidx/core/view/AccessibilityDelegateCompat;->onInitializeAccessibilityEvent(Landroid/view/View;Landroid/view/accessibility/AccessibilityEvent;)V

    .line 2167
    move-object v0, p1

    check-cast v0, Landroidx/core/widget/NestedScrollView;

    .line 2168
    .local v0, "nsvHost":Landroidx/core/widget/NestedScrollView;
    const-class v1, Landroid/widget/ScrollView;

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p2, v1}, Landroid/view/accessibility/AccessibilityEvent;->setClassName(Ljava/lang/CharSequence;)V

    .line 2169
    invoke-virtual {v0}, Landroidx/core/widget/NestedScrollView;->getScrollRange()I

    move-result v1

    if-lez v1, :cond_0

    const/4 v1, 0x1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    .line 2170
    .local v1, "scrollable":Z
    :goto_0
    invoke-virtual {p2, v1}, Landroid/view/accessibility/AccessibilityEvent;->setScrollable(Z)V

    .line 2171
    invoke-virtual {v0}, Landroidx/core/widget/NestedScrollView;->getScrollX()I

    move-result v2

    invoke-virtual {p2, v2}, Landroid/view/accessibility/AccessibilityEvent;->setScrollX(I)V

    .line 2172
    invoke-virtual {v0}, Landroidx/core/widget/NestedScrollView;->getScrollY()I

    move-result v2

    invoke-virtual {p2, v2}, Landroid/view/accessibility/AccessibilityEvent;->setScrollY(I)V

    .line 2173
    invoke-virtual {v0}, Landroidx/core/widget/NestedScrollView;->getScrollX()I

    move-result v2

    invoke-static {p2, v2}, Landroidx/core/view/accessibility/AccessibilityRecordCompat;->setMaxScrollX(Landroid/view/accessibility/AccessibilityRecord;I)V

    .line 2174
    invoke-virtual {v0}, Landroidx/core/widget/NestedScrollView;->getScrollRange()I

    move-result v2

    invoke-static {p2, v2}, Landroidx/core/view/accessibility/AccessibilityRecordCompat;->setMaxScrollY(Landroid/view/accessibility/AccessibilityRecord;I)V

    .line 2175
    return-void
.end method

.method public onInitializeAccessibilityNodeInfo(Landroid/view/View;Landroidx/core/view/accessibility/AccessibilityNodeInfoCompat;)V
    .locals 3
    .param p1, "host"    # Landroid/view/View;
    .param p2, "info"    # Landroidx/core/view/accessibility/AccessibilityNodeInfoCompat;

    .line 2141
    invoke-super {p0, p1, p2}, Landroidx/core/view/AccessibilityDelegateCompat;->onInitializeAccessibilityNodeInfo(Landroid/view/View;Landroidx/core/view/accessibility/AccessibilityNodeInfoCompat;)V

    .line 2142
    move-object v0, p1

    check-cast v0, Landroidx/core/widget/NestedScrollView;

    .line 2143
    .local v0, "nsvHost":Landroidx/core/widget/NestedScrollView;
    const-class v1, Landroid/widget/ScrollView;

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p2, v1}, Landroidx/core/view/accessibility/AccessibilityNodeInfoCompat;->setClassName(Ljava/lang/CharSequence;)V

    .line 2144
    invoke-virtual {v0}, Landroidx/core/widget/NestedScrollView;->isEnabled()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 2145
    invoke-virtual {v0}, Landroidx/core/widget/NestedScrollView;->getScrollRange()I

    move-result v1

    .line 2146
    .local v1, "scrollRange":I
    if-lez v1, :cond_1

    .line 2147
    const/4 v2, 0x1

    invoke-virtual {p2, v2}, Landroidx/core/view/accessibility/AccessibilityNodeInfoCompat;->setScrollable(Z)V

    .line 2148
    invoke-virtual {v0}, Landroidx/core/widget/NestedScrollView;->getScrollY()I

    move-result v2

    if-lez v2, :cond_0

    .line 2149
    sget-object v2, Landroidx/core/view/accessibility/AccessibilityNodeInfoCompat$AccessibilityActionCompat;->ACTION_SCROLL_BACKWARD:Landroidx/core/view/accessibility/AccessibilityNodeInfoCompat$AccessibilityActionCompat;

    invoke-virtual {p2, v2}, Landroidx/core/view/accessibility/AccessibilityNodeInfoCompat;->addAction(Landroidx/core/view/accessibility/AccessibilityNodeInfoCompat$AccessibilityActionCompat;)V

    .line 2151
    sget-object v2, Landroidx/core/view/accessibility/AccessibilityNodeInfoCompat$AccessibilityActionCompat;->ACTION_SCROLL_UP:Landroidx/core/view/accessibility/AccessibilityNodeInfoCompat$AccessibilityActionCompat;

    invoke-virtual {p2, v2}, Landroidx/core/view/accessibility/AccessibilityNodeInfoCompat;->addAction(Landroidx/core/view/accessibility/AccessibilityNodeInfoCompat$AccessibilityActionCompat;)V

    .line 2154
    :cond_0
    invoke-virtual {v0}, Landroidx/core/widget/NestedScrollView;->getScrollY()I

    move-result v2

    if-ge v2, v1, :cond_1

    .line 2155
    sget-object v2, Landroidx/core/view/accessibility/AccessibilityNodeInfoCompat$AccessibilityActionCompat;->ACTION_SCROLL_FORWARD:Landroidx/core/view/accessibility/AccessibilityNodeInfoCompat$AccessibilityActionCompat;

    invoke-virtual {p2, v2}, Landroidx/core/view/accessibility/AccessibilityNodeInfoCompat;->addAction(Landroidx/core/view/accessibility/AccessibilityNodeInfoCompat$AccessibilityActionCompat;)V

    .line 2157
    sget-object v2, Landroidx/core/view/accessibility/AccessibilityNodeInfoCompat$AccessibilityActionCompat;->ACTION_SCROLL_DOWN:Landroidx/core/view/accessibility/AccessibilityNodeInfoCompat$AccessibilityActionCompat;

    invoke-virtual {p2, v2}, Landroidx/core/view/accessibility/AccessibilityNodeInfoCompat;->addAction(Landroidx/core/view/accessibility/AccessibilityNodeInfoCompat$AccessibilityActionCompat;)V

    .line 2162
    .end local v1    # "scrollRange":I
    :cond_1
    return-void
.end method

.method public performAccessibilityAction(Landroid/view/View;ILandroid/os/Bundle;)Z
    .locals 6
    .param p1, "host"    # Landroid/view/View;
    .param p2, "action"    # I
    .param p3, "arguments"    # Landroid/os/Bundle;

    .line 2104
    invoke-super {p0, p1, p2, p3}, Landroidx/core/view/AccessibilityDelegateCompat;->performAccessibilityAction(Landroid/view/View;ILandroid/os/Bundle;)Z

    move-result v0

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    .line 2105
    return v1

    .line 2107
    :cond_0
    move-object v0, p1

    check-cast v0, Landroidx/core/widget/NestedScrollView;

    .line 2108
    .local v0, "nsvHost":Landroidx/core/widget/NestedScrollView;
    invoke-virtual {v0}, Landroidx/core/widget/NestedScrollView;->isEnabled()Z

    move-result v2

    const/4 v3, 0x0

    if-nez v2, :cond_1

    .line 2109
    return v3

    .line 2111
    :cond_1
    sparse-switch p2, :sswitch_data_0

    .line 2136
    return v3

    .line 2126
    :sswitch_0
    invoke-virtual {v0}, Landroidx/core/widget/NestedScrollView;->getHeight()I

    move-result v2

    invoke-virtual {v0}, Landroidx/core/widget/NestedScrollView;->getPaddingBottom()I

    move-result v4

    sub-int/2addr v2, v4

    .line 2127
    invoke-virtual {v0}, Landroidx/core/widget/NestedScrollView;->getPaddingTop()I

    move-result v4

    sub-int/2addr v2, v4

    .line 2128
    .local v2, "viewportHeight":I
    invoke-virtual {v0}, Landroidx/core/widget/NestedScrollView;->getScrollY()I

    move-result v4

    sub-int/2addr v4, v2

    invoke-static {v4, v3}, Ljava/lang/Math;->max(II)I

    move-result v4

    .line 2129
    .local v4, "targetScrollY":I
    invoke-virtual {v0}, Landroidx/core/widget/NestedScrollView;->getScrollY()I

    move-result v5

    if-eq v4, v5, :cond_2

    .line 2130
    invoke-virtual {v0, v3, v4, v1}, Landroidx/core/widget/NestedScrollView;->smoothScrollTo(IIZ)V

    .line 2131
    return v1

    .line 2134
    .end local v2    # "viewportHeight":I
    .end local v4    # "targetScrollY":I
    :cond_2
    return v3

    .line 2114
    :sswitch_1
    invoke-virtual {v0}, Landroidx/core/widget/NestedScrollView;->getHeight()I

    move-result v2

    invoke-virtual {v0}, Landroidx/core/widget/NestedScrollView;->getPaddingBottom()I

    move-result v4

    sub-int/2addr v2, v4

    .line 2115
    invoke-virtual {v0}, Landroidx/core/widget/NestedScrollView;->getPaddingTop()I

    move-result v4

    sub-int/2addr v2, v4

    .line 2116
    .restart local v2    # "viewportHeight":I
    invoke-virtual {v0}, Landroidx/core/widget/NestedScrollView;->getScrollY()I

    move-result v4

    add-int/2addr v4, v2

    .line 2117
    invoke-virtual {v0}, Landroidx/core/widget/NestedScrollView;->getScrollRange()I

    move-result v5

    .line 2116
    invoke-static {v4, v5}, Ljava/lang/Math;->min(II)I

    move-result v4

    .line 2118
    .restart local v4    # "targetScrollY":I
    invoke-virtual {v0}, Landroidx/core/widget/NestedScrollView;->getScrollY()I

    move-result v5

    if-eq v4, v5, :cond_3

    .line 2119
    invoke-virtual {v0, v3, v4, v1}, Landroidx/core/widget/NestedScrollView;->smoothScrollTo(IIZ)V

    .line 2120
    return v1

    .line 2123
    .end local v2    # "viewportHeight":I
    .end local v4    # "targetScrollY":I
    :cond_3
    return v3

    nop

    :sswitch_data_0
    .sparse-switch
        0x1000 -> :sswitch_1
        0x2000 -> :sswitch_0
        0x1020038 -> :sswitch_0
        0x102003a -> :sswitch_1
    .end sparse-switch
.end method
