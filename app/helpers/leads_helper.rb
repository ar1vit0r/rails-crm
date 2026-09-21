module LeadsHelper
  # Single source for stage colors: the dashboard strip and the lead rows both
  # read from here, so a stage color means one thing everywhere. Full class
  # names so Tailwind's scanner sees them. Order is the pipeline order.
  STAGES = {
    "new_lead" => { bg: "bg-stage-new", border: "border-l-stage-new" },
    "qualified" => { bg: "bg-stage-qualified", border: "border-l-stage-qualified" },
    "proposal" => { bg: "bg-stage-proposal", border: "border-l-stage-proposal" },
    "won" => { bg: "bg-stage-won", border: "border-l-stage-won" },
    "lost" => { bg: "bg-stage-lost", border: "border-l-stage-lost" }
  }.freeze

  def stage_bg(status)
    STAGES.fetch(status)[:bg]
  end

  def stage_border(status)
    STAGES.fetch(status)[:border]
  end

  def stage_label(status)
    status.delete_suffix("_lead").humanize
  end

  def priority_label(lead)
    Lead.priorities.key(Lead.priorities.fetch(lead.priority, 0)).humanize
  end

  # Three pips, filled up to the priority level. The sr-only label is skipped
  # when the caller already prints the priority name next to the pips.
  def priority_pips(lead, announce: true)
    level = Lead.priorities.fetch(lead.priority, 0)

    tag.span(class: "inline-flex items-center gap-1") do
      safe_join([
        (tag.span("#{priority_label(lead)} priority", class: "sr-only") if announce),
        *3.times.map { |i| tag.span(class: "h-2 w-2 rounded-full #{i <= level ? 'bg-bone' : 'bg-gray-600'}", aria: { hidden: true }) }
      ].compact)
    end
  end
end
