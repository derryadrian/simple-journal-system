// Journal dropdown hooks
export const JournalDropdown = {
  mounted() {
    this.handleClickAway = (event) => {
      if (!this.el.contains(event.target)) {
        this.pushEvent("hide_journal_dropdown", {});
      }
    };
    
    // Add click listener after a brief delay to avoid immediate close
    setTimeout(() => {
      document.addEventListener("click", this.handleClickAway);
    }, 0);
  },

  destroyed() {
    document.removeEventListener("click", this.handleClickAway);
  }
};

export const ToggleJournalDropdown = {
  mounted() {
    this.el.addEventListener("click", (event) => {
      event.stopPropagation();
      this.pushEvent("toggle_journal_dropdown", {});
    });
  }
};